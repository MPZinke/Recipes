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
from flask import render_template, request
import re


from Backend.Classes import Recipe
from Frontend.HTMLRenderingHelpers import format_decimal, format_decimal_fractionally, replace_special


def GET_recipes():
	"""Gets all recipes & displays them as a webpage."""
	recipes: list[Recipe] = Recipe.all()
	return render_template("Recipes/Index.j2", title="Recipes", recipes=recipes)


def GET_recipe(recipe_name: str):
	"""Gets a specific recipe & displays it as a webpage."""
	multiplier_text: str = request.args.get("multiplier", "1.0")
	if(re.fullmatch(r"[0-9]+(\.[0-9]+)?", multiplier_text) is None):
		raise Exception(r"Recipe multiplier must be of format '[0-9]+(\.[0-9]+)?'")

	multiplier = Decimal(multiplier_text)
	recipe: Recipe = Recipe.from_name(recipe_name) * multiplier
	args = {
		"format_decimal": format_decimal,
		"format_decimal_fractionally": format_decimal_fractionally,
		"replace_special": replace_special,
		"str": str
	}
	return render_template("Recipe/Index.j2", title=recipe.name(), recipe=recipe, **args)
