

import json
from typing import TypeVar


from Backend.DB import Queries


Ingredient = TypeVar("Ingredient");


class Ingredient:
	def __init__(self, *, id: int, brand: str, names: list[str], description: str):
		self._id: int = id
		self._brand: str = brand
		self._names: list[str] = names
		self._description: str = description


	@staticmethod
	def all() -> list[Ingredient]:
		ingredient_data: list[dict] = Queries.SELECT_ALL_FROM_Ingredients(ignore=["is_deleted"])
		ingredient_data.sort(key=lambda ingredient: ingredient["names"][0])
		return [Ingredient(**ingredient) for ingredient in ingredient_data]


	@staticmethod
	def search(search) -> list[Ingredient]:
		ingredient_data: list[dict] = Queries.SELECT_ALL_FROM_Ingredients_WHERE_name_like(search, ignore=["is_deleted"])
		ingredient_data.sort(key=lambda ingredient: ingredient["names"][0])
		return [Ingredient(**ingredient) for ingredient in ingredient_data]


	@staticmethod
	def from_id(id: int) -> Ingredient|None:
		if(not isinstance(id, int)):
			raise Exception(f"id must be of type 'int', not type '{type(id)}'")

		ingredient_data: dict|None = Queries.SELECT_ALL_FROM_Ingredients_WHERE_id(id, ignore=["is_deleted"])
		if(ingredient_data is None):
			return None

		return Ingredient(**ingredient_data)


	@staticmethod
	def from_name(name: str) -> Ingredient|None:
		if(not isinstance(name, str)):
			raise Exception(f"name must be of type 'str', not type '{type(name)}'")

		ingredient_data: dict|None = Queries.SELECT_ALL_FROM_Ingredients_WHERE_name(name, ignore=["is_deleted"])
		if(ingredient_data is None):
			return None

		return Ingredient(**ingredient_data)


	@staticmethod
	def validate(ingredient: dict) -> None:
		from Backend.Classes import validate_keys, validate_list

		types = {"id": int, "brand": str, "names": list, "description": str}
		validate_keys("Ingredient", ingredient, types)
		validate_list("Names", ingredient["names"], str)


	def __iter__(self) -> dict:
		yield from {
			"id": self._id,
			"brand": self._brand,
			"names": self._names,
			"description": self._description,
		}.items()


	def __repr__(self) -> str:
		return str(self)


	def __str__(self) -> str:
		return json.dumps(dict(self), indent=4)


	def id(self) -> str:
		return self._id


	def brand(self) -> str:
		return self._brand


	def names(self) -> list[str]:
		return self._names


	def description(self) -> str:
		return self._description
