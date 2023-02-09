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


from datetime import datetime, timedelta
from decimal import Decimal
from fractions import Fraction
import json
from math import prod
from typing import TypeVar


from DB import Queries
from RecipeIngredient import RecipeIngredient


Recipe = TypeVar("Recipe");


class Recipe(object):
	def __init__(self, *, id: int, name: str, instructions: dict|list, notes: str, rating: int,
	  servings: int, prep_time: timedelta, cook_time: timedelta, total_time: timedelta,
	  history: list[datetime], ingredients: list[RecipeIngredient]):
		self._id: int = id
		self._name: str = name
		self._instructions: dict|list = instructions
		self._notes: str = notes
		self._rating: int = rating
		self._servings: int = servings
		self._prep_time: timedelta = prep_time
		self._cook_time: timedelta = cook_time
		self._total_time: timedelta = total_time
		self._history: list[datetime] = history
		self._ingredients: list[RecipeIngredient] = ingredients


	@staticmethod
	def all() -> list[Recipe]:
		recipe_data: list[dict] = Queries.SELECT_ALL_FROM_Recipes()
		for recipe in recipe_data:
			recipe["ingredients"] = RecipeIngredient.from_Recipe_id(recipe["id"])
			recipe["history"] = Queries.SELECT_time_FROM_RecipesHistory_WHERE_Recipes_id(recipe["id"])

		return [Recipe(**recipe) for recipe in recipe_data]


	@staticmethod
	def from_name(name: str) -> Recipe | None:
		if(not isinstance(name, str)):
			raise Exception(f"name must be of type 'str', not type '{type(name)}'")

		recipe_data: dict|None = Queries.SELECT_ALL_FROM_Recipes_WHERE_name(name)
		if(recipe_data is None):
			return None

		recipe_data["history"] = Queries.SELECT_time_FROM_RecipesHistory_WHERE_Recipes_id(recipe_data["id"])
		recipe_data["ingredients"] = RecipeIngredient.from_Recipe_id(recipe_data["id"])

		return Recipe(**recipe_data)


	def __iter__(self) -> dict:
		yield from {
			"id": self._id,
			"name": self._name,
			"instructions": self._instructions,
			"notes": self._notes,
			"rating": self._rating,
			"servings": self._servings,
			"prep_time": self._prep_time,
			"cook_time": self._cook_time,
			"total_time": self._total_time,
			"history": map(str, self._history),
			"ingredients": map(dict, self._ingredients)
		}.items()


	def __repr__(self) -> str:
		return str(self)


	def __str__(self) -> str:
		return json.dumps(dict(self), indent=4)


	def id(self) -> int:
		return self._id


	def is_deleted(self) -> bool:
		return self._is_deleted


	def last_made_on(self) -> datetime|None:
		if(len(self._history) == 0):
			return None

		return self._history[-1]


	def name(self) -> str:
		return self._name


	def instructions(self) -> dict|list:
		return self._instructions


	def notes(self) -> str:
		return self._notes


	def rating(self) -> int:
		return self._rating


	def servings(self) -> int:
		return self._servings


	def prep_time(self) -> timedelta:
		return self._prep_time


	def cook_time(self) -> timedelta:
		return self._cook_time


	def total_time(self) -> timedelta:
		return self._total_time


	def ingredients(self) -> list[RecipeIngredient]:
		return self._ingredients


	# ——————————————————————————————————————————————————— SPECIAL  ——————————————————————————————————————————————————— #

	def __mul__(self, amount: int|float|Decimal|Fraction) -> Recipe:  # __mul__(left, right)
		if(isinstance(amount, float)):
			amount = Decimal(amount)

		servings = self._servings * amount
		if(isinstance(amount, Fraction)):
			amount = Decimal(float(amount))
			servings = Decimal(float(servings))

		ingredients: list[RecipeIngredient] = [ingredient * amount for ingredient in self._ingredients]
		return Recipe(id=self._id, name=self._name, instructions=self._instructions, notes=self._notes,
		  rating=self._rating, servings=servings, prep_time=self._prep_time, cook_time=self._cook_time,
		  total_time=self._total_time, history=self._history, ingredients=ingredients)


	def __rmul__(self, amount: int|float|Decimal|Fraction) -> Recipe:  # __mul__(right, left)
		return self * amount


	def __imul__(self, amount: int|float|Decimal|Fraction) -> None:
		if(isinstance(amount, float)):
			amount = Decimal(amount)

		print(self._servings)
		self._servings *= amount
		print(self._servings)
		if(isinstance(amount, Fraction)):
			amount = Decimal(float(amount))
			self._servings = Decimal(float(self._servings))

		for ingredient in self._ingredients:
			ingredient *= amount

		return self
