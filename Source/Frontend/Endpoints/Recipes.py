#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.03.06                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


from decimal import Decimal
from pathlib import Path
import re


from flask import Blueprint, render_template, request


from backend.classes import Recipe


ROOT_DIR = Path(__file__).absolute().parent
TEMPLATE_FOLDER = ROOT_DIR / "Frontend/Templates"
STATIC_FOLDER = ROOT_DIR / "Frontend/Static"
BLUEPRINT = Blueprint("recipes", __name__, template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)


@BLUEPRINT.route("/")
@BLUEPRINT.route("/recipes")
def recipes():
	"""Gets all recipes & displays them as a webpage."""
	recipes: list[Recipe] = Recipe.all()
	return render_template("Recipes/Index.j2", title="Recipes", recipes=recipes)


@BLUEPRINT.route("/recipe/<string:recipe_name>")
def recipe(recipe_name: str):
	"""Gets a specific recipe & displays it as a webpage."""
	multiplier_text: str = request.args.get("multiplier", "1.0")
	if(re.fullmatch(r"[0-9]+(\.[0-9]+)?", multiplier_text) is None):
		raise Exception(r"Recipe multiplier must be of format '[0-9]+(\.[0-9]+)?'")

	multiplier = Decimal(multiplier_text)
	recipe: Recipe = Recipe.from_name(recipe_name) * multiplier
	return render_template("Recipe/Index.j2", title=recipe.name(), recipe=recipe)
