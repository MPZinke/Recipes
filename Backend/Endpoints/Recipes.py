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


from Classes import Recipe


def GET_recipes():
	recipes: list[Recipe] = Recipe.all()
	return render_template("Recipes/Index.j2", title="Recipes", recipes=recipes)


def GET_recipe(recipe_name: str):
	multiplier_text: str = request.args.get("multiplier", "1.0")
	if(re.fullmatch(r"[0-9]+(\.[0-9]+)?", multiplier_text) is None):
		raise Exception(r"Recipe multiplier must be of format '[0-9]+(\.[0-9]+)?'")

	multiplier = Decimal(multiplier_text)
	recipe: Recipe = Recipe.from_name(recipe_name) * multiplier
	return render_template("Recipe/Index.j2", title=recipe.name(), recipe=recipe)
