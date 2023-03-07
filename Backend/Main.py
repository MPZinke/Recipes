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
from Classes import Ingredient, Recipe
import Endpoints
from HTMLRenderingHelpers import format_decimal, format_decimal_fractionally, replace_special


ROOT_DIR = str(Path(__file__).absolute().parent)
TEMPLATE_FOLDER = os.path.join(ROOT_DIR, "Templates")
STATIC_FOLDER = os.path.join(ROOT_DIR, "Static")
app = Flask("Recipes", template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)

# FROM: https://stackoverflow.com/a/39858522
app.jinja_env.add_extension('jinja2.ext.do')
# FROM: https://abstractkitchen.com/blog/how-to-create-custom-jinja-filters-in-flask/
app.jinja_env.filters["format_decimal"] = format_decimal
app.jinja_env.filters["format_decimal_fractionally"] = format_decimal_fractionally
app.jinja_env.filters["replace_special"] = replace_special
app.jinja_env.filters["str"] = str


@app.route("/")
def GET_():
	return Endpoints.Recipes.GET_recipes()


@app.route("/favicon.ico")
def GET_favicon_ico():
	return ""


# ————————————————————————————————————————————————————— RECIPES  ————————————————————————————————————————————————————— #
# ———————————————————————————————————————————————————————————————————————————————————————————————————————————————————— #

# ——————————————————————————————————————————————————— RECIPES::NEW ——————————————————————————————————————————————————— #

@app.route("/new", methods=["GET", "POST"])
def GET_POST_new():
	if(request.method == "GET"):
		ingredients: list[Ingredient] = Ingredient.all()
		return render_template("New/Index.j2", title="New Recipe", ingredients=ingredients)
	else:
		return ""


@app.route("/new/recipe_ingredient", methods=["GET"])
def GET_new_recipe_ingredient():
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("New/RecipeIngredient/New.j2", ingredients=ingredients)


@app.route("/new/instruction/section", methods=["GET"])
def GET_new_instruction_section():
	return render_template("New/Instruction/Section.j2")


@app.route("/new/instruction/section-dictionary", methods=["GET"])
def GET_new_instruction_section_dictionary():
	return render_template("New/Instruction/SectionDictionary.j2")


@app.route("/new/instruction/step", methods=["GET"])
def GET_new_instruction_step():
	return render_template("New/Instruction/Step.j2")


@app.route("/new/instruction/step/<string:section>", methods=["GET"])
def GET_new_instruction_step_section(section: str):
	return render_template("New/Instruction/Step.j2", section=section)


@app.route("/new/instruction/step-list", methods=["GET"])
def GET_new_instruction_step_list():
	return render_template("New/Instruction/StepList.j2")


# ——————————————————————————————————————————————————— INGREDIENTS  ——————————————————————————————————————————————————— #


# —————————————————————————————————————————————————————— TIMER  —————————————————————————————————————————————————————— #

@app.route("/timer/<string:duration>", methods=["GET"])
def GET_timer(duration: str):
	if(re.fullmatch(r"[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}", duration) is None):
		raise Exception(f"Duration of '{duration}' is not of correct format 'HH:MM:SS'")

	return render_template("Timer/Index.j2", title="Timer")

# ————————————————————————————————————————————————— API::INGREDIENTS ————————————————————————————————————————————————— #

@app.route("/api/ingredients")
def GET_api_ingredients():
	ingredients: list[Ingredient] = Ingredient.all()
	return str(ingredients)


def main():
	add_url(app, "/recipes", Endpoints.Recipes.GET_recipes)
	add_url(app, "/recipe/<string:recipe_name>", Endpoints.Recipes.GET_recipe)

	add_url(app, "/ingredients", Endpoints.Ingredients.GET_ingredients)
	add_url(app, "/ingredients/<string:search>", Endpoints.Ingredients.GET_ingredients_search)
	add_url(app, "/ingredient/<string:ingredient_name>", Endpoints.Ingredients.GET_ingredient)
	app.run(host="0.0.0.0", port=8080, debug=True)


if(__name__ == "__main__"):
	main()
