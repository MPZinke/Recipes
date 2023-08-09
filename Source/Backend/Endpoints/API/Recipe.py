#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.03.18                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


from datetime import timedelta
from decimal import Decimal
from flask import request
import json
from typing import Any
from werkzeug.exceptions import HTTPException, BadRequest


from Backend.Classes import Recipe, RecipeIngredient


def GET_recipes() -> str:
	"""Gets all recipes and returns them in a JSON format."""
	return json.dumps([recipe.name() for recipe in Recipe.all()], indent=4, default=str)


def POST_recipe_new() -> str:
	"""Creates a new recipe and returns it in a JSON format."""
	print(request.data)
	try:
		recipe: dict = {"id": 0, "history": [], **request.json}
		for key in ["cook_time", "prep_time", "total_time"]:
			recipe[key] = timedelta(minutes=recipe[key])

		ids = {"id": 0, "Ingredients_id": 0}
		for x, ingredient in enumerate((ingredients := recipe["ingredients"])):
			recipe["ingredients"][x] = {**ingredient, **ids, "amount": Decimal(ingredient["amount"])}

		recipe = Recipe(**{**recipe, "ingredients": [RecipeIngredient(**ingredient) for ingredient in ingredients]})
		recipe.add()

		return json.dumps({"id": recipe.id()})

	except (KeyError, ValueError) as error:
		raise BadRequest(description=str(error))
