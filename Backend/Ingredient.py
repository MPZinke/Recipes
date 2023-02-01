

from typing import TypeVar


from DB import Queries


Ingredient = TypeVar("Ingredient");


class Ingredient:
	def __init__(self, *, id: int, is_deleted: bool, brand: str, names: list[str], description: str):
		self._id: int = id
		self._is_deleted: bool = is_deleted
		self._brand: str = brand
		self._names: list[str] = names
		self._description: str = description


	@staticmethod
	def from_name(name: str) -> Ingredient|None:
		if(not isinstance(name, str)):
			raise Exception(f"name must be of type 'str', not type '{type(name)}'")

		ingredient_data: dict|None = Queries.SELECT_ALL_FROM_Ingredients_WHERE_name(name)
		if(ingredient_data is None):
			return None

		return Ingredient(**ingredient_data)


	def id(self) -> str:
		return self._id


	def brand(self) -> str:
		return self._brand


	def names(self) -> list[str]:
		return self._names


	def description(self) -> str:
		return self._description
