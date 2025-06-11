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


import os
from pathlib import Path
import requests
from typing import Optional


from flask import Blueprint


from backend.classes import Recipe


HOME_ASSISTANT_DOMAIN = os.getenv("HOME_ASSISTANT_DOMAIN")
HOME_ASSISTANT_TOKEN = os.getenv("HOME_ASSISTANT_TOKEN")


BLUEPRINT = Blueprint("api_home_assistant", __name__)


@BLUEPRINT.route("/api/recipes/<string:recipe_name>/add_to_home_assistant", methods=["POST"])
async def add_to_home_assistant(recipe_name: str) -> list[str]:
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
