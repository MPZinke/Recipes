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
import json
import os
from pathlib import Path


from flask import request, Flask
from jinja2 import Environment, FileSystemLoader
import mpzinke


import Backend
import Frontend
from Frontend.HTMLRenderingHelpers import format_decimal, format_decimal_fractionally, render_value


ROOT_DIR = Path(__file__).absolute().parent
TEMPLATE_FOLDER = ROOT_DIR / "Frontend/Templates"
STATIC_FOLDER = ROOT_DIR / "Frontend/Static"


def handle_error(error):
	"""
	SUMMARY: Handles the return response for any server error that occurs during a request.
	PARAMS:  Takes the error that has occured.
	FROM: https://readthedocs.org/projects/pallet/downloads/pdf/latest/
	 AND: https://stackoverflow.com/a/29332131
	"""
	if(os.path.normpath(request.path).split(os.sep)[1] == "api"):
		return Backend.Endpoints.API.handle_error(error)
	else:
		raise error

APP = Flask("Recipes", template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)



server = mpzinke.Server(name="Recipes", authorization=mpzinke.Server.no_auth, handle_error=handle_error, port=80,
  template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)
server._app.jinja_env.globals["format_decimal_fractionally"] = format_decimal_fractionally
server._app.jinja_env.globals["Decimal"] = Decimal
server._app.jinja_env.filters["render_value"] = render_value(server._app)


macro_template = server._app.jinja_env.get_template('Macros.j2')
macro_namespace = macro_template.make_module({})  # Create a namespace for macros
for name, macro in macro_namespace.__dict__.items():
	if(not name.startswith("_")):
		server._app.jinja_env.globals[name] = macro

# @server._app.before_request
# def register_macros():
# 	env = Environment(loader=FileSystemLoader(TEMPLATE_FOLDER))
	# macro_template = env.get_template('Macros.j2')
	# macro_namespace = macro_template.make_module({})  # Create a namespace for macros

# 	# Register macros globally
# 	for name, macro in macro_namespace.__dict__.items():
# 		if(not name.startswith("_")):
# 			server._app.jinja_env.globals[name] = macro
	# server._app.jinja_env.globals["checkbox_list"] = macro_namespace.checkbox_list
	# server._app.jinja_env.globals["quantity"] = macro_namespace.quantity
	# server._app.jinja_env.globals["timer"] = macro_namespace.timer
	# server._app.jinja_env.globals["title"] = macro_namespace.title

def main():
	# # FROM: https://stackoverflow.com/a/39858522
	# server.jinja_env.add_extension('jinja2.ext.do')
	# # FROM: https://abstractkitchen.com/blog/how-to-create-custom-jinja-filters-in-flask/
	# server.jinja_env.filters["format_decimal"] = format_decimal
	# server.jinja_env.filters["replace_special"] = replace_special
	# server.jinja_env.filters["str"] = str

	server.route("/", Frontend.Endpoints.Recipes.GET_recipes)
	server.route("/favicon.ico", Frontend.Endpoints.GET_favicon_icon)

	server.route("/recipes", Frontend.Endpoints.Recipes.GET_recipes)
	server.route("/recipe/<string:recipe_name>", Frontend.Endpoints.Recipes.GET_recipe)

	server.route("/ingredients", Frontend.Endpoints.Ingredients.GET_ingredients)
	server.route("/ingredients/<string:search>", Frontend.Endpoints.Ingredients.GET_ingredients_search)
	server.route("/ingredient/<string:ingredient_name>", Frontend.Endpoints.Ingredients.GET_ingredient)

	server.route("/new/recipe", GET=Frontend.Endpoints.New.GET_new_recipe)
	server.route("/new/recipe/recipe_ingredient", POST=Frontend.Endpoints.New.POST_new_recipe_ingredient)
	server.route("/new/recipe/instruction/section", POST=Frontend.Endpoints.New.POST_new_instruction_section)
	server.route("/new/recipe/instruction/list", POST=Frontend.Endpoints.New.POST_new_instruction)

	server.route("/api/recipes", Backend.Endpoints.API.Recipe.GET_recipes)
	server.route("/api/ingredients", Backend.Endpoints.API.Ingredients.GET_ingredients)
	server.route("/api/recipes/<string:recipe_name>/add_to_home_assistant", POST=Backend.Endpoints.API.HomeAssistant.POST_add_to_home_assistant)
	server.route("/api/recipe/new", POST=Backend.Endpoints.API.Recipe.POST_recipe_new)

	print(json.dumps(dict(server), indent=4))

	server()


if(__name__ == "__main__"):
	main()
