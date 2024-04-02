#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2024.02.20                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


import asyncio
import os
import requests
from typing import Optional


from Backend.Classes import Recipe


HOME_ASSISTANT_DOMAIN = os.getenv("HOME_ASSISTANT_DOMAIN")
HOME_ASSISTANT_TOKEN = os.getenv("HOME_ASSISTANT_TOKEN")


async def POST_add_to_home_assistant(recipe_name: str) -> list[str]:
	"""
	"""
	recipe: Optional[Recipe] = Recipe.from_name(recipe_name)

	ingredient_strings: list[str] = []

	url = f"{HOME_ASSISTANT_DOMAIN}/api/services/shopping_list/add_item"
	headers = {"Authorization": f"Bearer {HOME_ASSISTANT_TOKEN}"}
	for ingredient in recipe.ingredients():
		ingredient_amount = round(ingredient.amount(), 2)
		ingredient_unit = ingredient.unit(ingredient_amount)
		ingredient_name = ingredient.name(ingredient_amount)
		ingredient_string = f"{ingredient_amount} {ingredient_unit}{' ' if(ingredient_unit) else ''}{ingredient_name}"

		ingredient_strings.append(ingredient_string)
		requests.post(url, headers=headers, json={"name": ingredient_string}, timeout=15)

	return ingredient_strings
