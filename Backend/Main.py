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
import os
from pathlib import Path
import re


from DB import Queries
from Recipe import Recipe
from Ingredient import Ingredient


ROOT_DIR = str(Path(__file__).absolute().parent)
app = Flask("Recipes", template_folder=os.path.join(ROOT_DIR, "Templates"))


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
		raise Exception("")

	duration_times = [int(time) for time in duration.split(":")]
	duration_ms = 3_600_000 * duration_times[0] + 60_000 * duration_times[1] + 1_000 * duration_times[2]

	return render_template("timer.j2", duration=duration_ms)


def main():
	app.run(host="0.0.0.0", port=8080)


if(__name__ == "__main__"):
	main()
