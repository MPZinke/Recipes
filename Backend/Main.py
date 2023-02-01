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


from flask import Flask, render_template
from jinja2 import Environment
import os
from pathlib import Path
import re


from DB import Queries
from Recipe import Recipe
from Ingredient import Ingredient
from HTMLRenderingHelpers import replace_timer


ROOT_DIR = str(Path(__file__).absolute().parent)
app = Flask("Recipes", template_folder=os.path.join(ROOT_DIR, "Templates"))


# FROM: https://abstractkitchen.com/blog/how-to-create-custom-jinja-filters-in-flask/
app.jinja_env.filters["replace_timer"]=replace_timer


@app.route("/recipes", methods=["GET"])
def GET_recipes():
	recipes: list[Recipe] = Recipe.all()
	return render_template("recipes.j2", recipes=recipes)


@app.route("/recipe/<string:recipe_name>", methods=["GET"])
def GET_recipe(recipe_name: str):
	recipe: Recipe = Recipe.from_name(recipe_name)
	return render_template("recipe.j2", recipe=recipe)


@app.route("/ingredient/<string:ingredient_name>", methods=["GET"])
def GET_ingredient(ingredient_name: str):
	ingredient: Ingredient = Ingredient.from_name(ingredient_name)
	recipes: list[dict] = Queries.SELECT_Recipes_name_FROM_RecipesIngredients_WHERE_Ingredients_name(ingredient_name)
	recipe_names: list[str] = [recipe["name"] for recipe in recipes]
	return render_template("ingredient.j2", ingredient=ingredient, recipe_names=recipe_names)


@app.route("/timer/<string:duration>", methods=["GET"])
def GET_timer(duration: str):
	if(re.fullmatch(r"[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}", duration) is None):
		raise Exception(f"Duration of '{duration}' is not of correct format 'HH:MM:SS'")

	return render_template("timer.j2")


def main():
	app.run(host="0.0.0.0", port=8080, debug=True)


if(__name__ == "__main__"):
	main()
