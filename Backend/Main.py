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


from DB import Queries
from Recipe import Recipe


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


def main():
	app.run(host="0.0.0.0", port=8080)


if(__name__ == "__main__"):
	main()
