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
from flask import Flask, redirect, render_template, request, url_for
from fractions import Fraction
from jinja2 import Environment
import os
from pathlib import Path
import re


from DB import Queries
from Classes import Ingredient, Recipe
from HTMLRenderingHelpers import format_decimal, format_decimal_fractionally, replace_special


ROOT_DIR = str(Path(__file__).absolute().parent)
app = Flask("Recipes", template_folder=os.path.join(ROOT_DIR, "Templates"), static_folder=os.path.join(ROOT_DIR, "Static"))


# FROM: https://abstractkitchen.com/blog/how-to-create-custom-jinja-filters-in-flask/
app.jinja_env.filters["format_decimal"] = format_decimal
app.jinja_env.filters["format_decimal_fractionally"] = format_decimal_fractionally
app.jinja_env.filters["replace_special"] = replace_special
app.jinja_env.filters["str"] = str


@app.route("/")
def GET_():
	# FROM: https://stackoverflow.com/a/36011663
	# return "<a href='alarm-clock://' target='_blank'>Timer</a>"
	return "<a href='clock-timer://'>Timer</a>"


@app.route("/favicon.ico")
def GET_favicon_ico():
	return ""


@app.route("/testing/tooltip")
def GET_testing_datatlist():
	return """
	<span title="See this when you hover">
		Ingredient
	</span>
"""

# ————————————————————————————————————————————————————— RECIPES  ————————————————————————————————————————————————————— #
# ———————————————————————————————————————————————————————————————————————————————————————————————————————————————————— #

@app.route("/recipes", methods=["GET"])
def GET_recipes():
	recipes: list[Recipe] = Recipe.all()
	return render_template("Recipes/Index.j2", title="Recipes", recipes=recipes)


@app.route("/recipe/<string:recipe_name>", methods=["GET"])
def GET_recipe(recipe_name: str):
	multiplier_text: str = request.args.get("multiplier", "1.0")
	if(re.fullmatch(r"[0-9]+(\.[0-9]+)?", multiplier_text) is None):
		raise Exception(r"Recipe multiplier must be of format '[0-9]+(\.[0-9]+)?'")

	multiplier = Decimal(multiplier_text)
	recipe: Recipe = Recipe.from_name(recipe_name) * multiplier
	return render_template("Recipe/Index.j2", title=recipe.name(), recipe=recipe)


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

@app.route("/ingredients", methods=["GET"])
def GET_ingredients():
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("Ingredients/Index.j2", title="Ingredients", ingredients=ingredients)


@app.route("/ingredient/<string:ingredient_name>", methods=["GET"])
def GET_ingredient(ingredient_name: str):
	ingredient: Ingredient = Ingredient.from_name(ingredient_name)
	recipe_names: list[str] = Queries.SELECT_Recipes_name_FROM_RecipesIngredients_WHERE_Ingredients_name(ingredient_name)
	return render_template("Ingredient/Index.j2", title=ingredient.names()[0], ingredient=ingredient,
	  recipe_names=recipe_names)


@app.route("/timer/<string:duration>", methods=["GET"])
def GET_timer(duration: str):
	if(re.fullmatch(r"[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}", duration) is None):
		raise Exception(f"Duration of '{duration}' is not of correct format 'HH:MM:SS'")

	return render_template("Timer/Index.j2", title="Timer")


@app.route("/api/ingredients")
def GET_api_ingredients():
	ingredients: list[Ingredient] = Ingredient.all()
	return str(ingredients)


def main():
	app.run(host="0.0.0.0", port=8080, debug=True)


if(__name__ == "__main__"):
	main()
