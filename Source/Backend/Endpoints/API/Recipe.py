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


from flask import request


from Backend.Classes import Recipe


def POST_recipe_new() -> str:
	print(request.data)
	recipe: dict = {"id": 0, "history": [], **request.json}
	for recipe_ingredient in recipe["ingredients"]:
		recipe_ingredient["id"] = 0
		recipe_ingredient["Ingredient_id"] = 0

	Recipe.validate(recipe)
	return ""
	# recipe: dict = request.json


