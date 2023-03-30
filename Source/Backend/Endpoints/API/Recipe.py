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
from flask import request
import json
from typing import Any
from werkzeug.exceptions import HTTPException, BadRequest


from Backend.Classes import Recipe, RecipeIngredient


def POST_recipe_new() -> str:
	print(request.data)
	# try:
	recipe_dict: dict = {"id": 0, "history": [], **request.json}
	for key in ["cook_time", "prep_time", "total_time"]:
		recipe_dict[key] = timedelta(minutes=recipe_dict[key])

	for x, ingredient in enumerate((ingredients := recipe_dict["ingredients"])):
		recipe_dict["ingredients"][x] = {"id": 0, "Ingredients_id": 0, **ingredient}

	Recipe.validate(recipe_dict)
	recipe = Recipe(**{**recipe_dict, "ingredients": [RecipeIngredient(**ingredient) for ingredient in ingredients]})
	recipe.add()

	return json.dumps({"id": recipe.id()})

	# except (KeyError, ValueError) as error:
	# 	raise BadRequest(description=str(error))
