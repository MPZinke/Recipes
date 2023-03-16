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


from flask import Flask, render_template, request
import os
from pathlib import Path
import re


from __init__ import add_url
import Backend
import Frontend
from Frontend.HTMLRenderingHelpers import format_decimal, format_decimal_fractionally, replace_special


ROOT_DIR = str(Path(__file__).absolute().parent)
TEMPLATE_FOLDER = os.path.join(ROOT_DIR, "Frontend/Templates")
STATIC_FOLDER = os.path.join(ROOT_DIR, "Frontend/Static")


def add_frontend_routes(server: Flask) -> None:
	add_url(server, "/", Frontend.Endpoints.Recipes.GET_recipes)
	add_url(server, "/favicon.ico", Frontend.Endpoints.GET_favicon_icon)

	add_url(server, "/recipes", Frontend.Endpoints.Recipes.GET_recipes)
	add_url(server, "/recipe/<string:recipe_name>", Frontend.Endpoints.Recipes.GET_recipe)

	add_url(server, "/ingredients", Frontend.Endpoints.Ingredients.GET_ingredients)
	add_url(server, "/ingredients/<string:search>", Frontend.Endpoints.Ingredients.GET_ingredients_search)
	add_url(server, "/ingredient/<string:ingredient_name>", Frontend.Endpoints.Ingredients.GET_ingredient)

	New = Frontend.Endpoints.New
	add_url(server, "/new/recipe", GET=New.GET_new_recipe)
	add_url(server, "/new/recipe/recipe_ingredient", POST=New.POST_new_recipe_ingredient)
	add_url(server, "/new/recipe/instruction/section", POST=New.POST_new_instruction_section)
	add_url(server, "/new/recipe/instruction/list", POST=New.POST_new_instruction)


def add_api_routes(server: Flask) -> None:
	add_url(server, "/api/ingredients", Backend.Endpoints.API.Ingredients.GET_ingredients)


# —————————————————————————————————————————————————————— TIMER  —————————————————————————————————————————————————————— #

# @app.route("/timer/<string:duration>", methods=["GET"])
# def GET_timer(duration: str):
# 	if(re.fullmatch(r"[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}", duration) is None):
# 		raise Exception(f"Duration of '{duration}' is not of correct format 'HH:MM:SS'")

# 	return render_template("Timer/Index.j2", title="Timer")



def main():
	server = Flask("Recipes", template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)
	# FROM: https://stackoverflow.com/a/39858522
	server.jinja_env.add_extension('jinja2.ext.do')
	# FROM: https://abstractkitchen.com/blog/how-to-create-custom-jinja-filters-in-flask/
	server.jinja_env.filters["format_decimal"] = format_decimal
	server.jinja_env.filters["format_decimal_fractionally"] = format_decimal_fractionally
	server.jinja_env.filters["replace_special"] = replace_special
	server.jinja_env.filters["str"] = str

	add_frontend_routes(server)
	add_api_routes(server)

	server.run(host="0.0.0.0", port=8080, debug=True)


if(__name__ == "__main__"):
	main()
