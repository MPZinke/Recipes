#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.01.21                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


from decimal import Decimal
import os
from pathlib import Path


from flask import request, Flask


import backend
from backend.endpoints.api.home_assistant import BLUEPRINT as backend_home_assistant_blueprint
from backend.endpoints.api.ingredients import BLUEPRINT as backend_ingredients_blueprint
from backend.endpoints.api.recipe import BLUEPRINT as backend_recipe_blueprint
from frontend.endpoints.ingredients import BLUEPRINT as frontend_ingredients_blueprint
from frontend.endpoints.new import BLUEPRINT as frontend_new_blueprint
from frontend.endpoints.recipes import BLUEPRINT as frontend_recipes_blueprint
from frontend.html_rendering_helpers import add_helpers


ROOT_DIR = Path(__file__).absolute().parent
TEMPLATE_FOLDER = ROOT_DIR / "frontend/Templates"
STATIC_FOLDER = ROOT_DIR / "frontend/Static"


def after_request(response):
	"""
	FROM: https://stackoverflow.com/a/30717205
	"""
	response.headers["Version"] = os.getenv("VERSION", "0.0.1")
	return response


def handle_error(error):
	"""
	SUMMARY: Handles the return response for any server error that occurs during a request.
	PARAMS:  Takes the error that has occured.
	FROM: https://readthedocs.org/projects/pallet/downloads/pdf/latest/
	 AND: https://stackoverflow.com/a/29332131
	"""
	if(os.path.normpath(request.path).split(os.sep)[1] == "api"):
		return backend.endpoints.api.handle_error(error)
	else:
		raise error


def main():
	app = Flask("Recipes", template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)
	app.register_error_handler(Exception, handle_error)
	app.after_request(after_request)
	app.jinja_env.globals["Decimal"] = Decimal
	add_helpers(app)

	app.register_blueprint(frontend_ingredients_blueprint)
	app.register_blueprint(frontend_new_blueprint)
	app.register_blueprint(frontend_recipes_blueprint)

	app.register_blueprint(backend_home_assistant_blueprint)
	app.register_blueprint(backend_ingredients_blueprint)
	app.register_blueprint(backend_recipe_blueprint)

	app.run(debug=True, host="0.0.0.0", port=443)


if(__name__ == "__main__"):
	main()
