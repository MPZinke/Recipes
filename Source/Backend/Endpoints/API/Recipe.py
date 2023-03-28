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
from werkzeug.exceptions import HTTPException, BadRequest


from Backend.Classes import Recipe


def POST_recipe_new() -> str:
	print(request.data)
	# try:
	recipe: dict = {"id": 0, "history": [], **request.json}
	for key in ["cook_time", "prep_time", "total_time"]:
		recipe[key] = timedelta(minutes=recipe[key])

	for x, ingredient in enumerate(recipe["ingredients"]):
		recipe["ingredients"][x] = {"id": 0, "Ingredients_id": 0, **ingredient}

	Recipe.validate(recipe)

	return ""

	# except (KeyError, ValueError) as error:
	# 	raise BadRequest(description=str(error))
