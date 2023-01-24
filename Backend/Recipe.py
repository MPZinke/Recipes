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


from datetime import timedelta
from typing import TypeVar


from DB import Queries
from RecipeIngredient import RecipeIngredient


Recipe = TypeVar("Recipe");


class Recipe(object):
	def __init__(self, *, id: int, is_deleted: bool, name: str, instructions: dict|list, rating: int, serving_size: int,
	  prep_time: timedelta, cook_time: timedelta, total_time: timedelta, ingredients: list[RecipeIngredient]):
		self._id: int = id
		self._is_deleted: bool = is_deleted
		self._name: str = name
		self._instructions: dict|list = instructions
		self._rating: int = rating
		self._serving_size: int = serving_size
		self._prep_time: timedelta = prep_time
		self._cook_time: timedelta = cook_time
		self._total_time: timedelta = total_time
		self._ingredients: list[RecipeIngredient] = ingredients


	@staticmethod
	def all() -> list[Recipe]:
		recipe_data: list[dict] = Queries.SELECT_ALL_FROM_Recipes()
		[recipe.update({"ingredients": RecipeIngredient.from_Recipe_id(recipe["id"])}) for recipe in recipe_data]
		return [Recipe(**recipe) for recipe in recipe_data]


	@staticmethod
	def from_name(name: str) -> Recipe | None:
		if(not isinstance(name, str)):
			raise Exception(f"name must be of type 'str', not type '{type(name)}'")

		recipe_data: dict|None = Queries.SELECT_ALL_FROM_Recipes_WHERE_name(name)
		if(recipe_data is None):
			return None

		recipe_data["ingredients"] = RecipeIngredient.from_Recipe_id(recipe_data["id"])

		return Recipe(**recipe_data)


	def id(self) -> int:
		return self._id


	def is_deleted(self) -> bool:
		return self._is_deleted


	def name(self) -> str:
		return self._name


	def instructions(self) -> dict|list:
		return self._instructions


	def rating(self) -> int:
		return self._rating


	def serving_size(self) -> int:
		return self._serving_size


	def prep_time(self) -> timedelta:
		return self._prep_time


	def cook_time(self) -> timedelta:
		return self._cook_time


	def total_time(self) -> timedelta:
		return self._total_time


	def ingredients(self) -> list[RecipeIngredient]:
		return self._ingredients