

from decimal import Decimal
import json
from typing import TypeVar, Optional


from backend.classes import Ingredient
from backend.db import queries


RecipeIngredient = TypeVar("Recipe")


class RecipeIngredient(Ingredient):
	def __init__(self, *, id: int, amount: Optional[Decimal], brand: str, names: list[str], description: str, group: str,
		Ingredients_id: int, is_required: bool, quality: str, notes: str, units: list[str]
	):
		Ingredient.__init__(self, id=Ingredients_id, brand=brand, names=names, description=description)

		self._Ingredients_id: int = Ingredients_id

		self._id: int = id
		self._group: str = group
		self._amount: Decimal = amount
		self._units: list[str] = units
		self._quality: str = quality
		self._is_required: bool = is_required
		self._notes: str = notes


	@staticmethod
	def from_Ingredient_name(name: str) -> RecipeIngredient|None:
		if(not isinstance(name, str)):
			raise Exception(f"name must be of type 'str', not type '{type(name)}'")

		recipe_ingredient_data: dict|None = queries.SELECT_ALL_FROM_RecipesIngredients_WHERE_Ingredients_name(name,
		  ignore=["is_deleted"])
		if(recipe_ingredient_data is None):
			return None

		recipe_ingredient_data.update({"Ingredients_id": recipe_ingredient_data.pop("Ingredients.id")})
		recipe_ingredient_data.pop("Recipes.id")

		return RecipeIngredient(**recipe_ingredient_data)


	@staticmethod
	def from_Recipe_id(Recipe_id: int) -> list[RecipeIngredient]:
		if(not isinstance(Recipe_id, int)):
			raise Exception(f"Recipe_id must be of type 'int', not type '{type(Recipe_id)}'")

		ingredient_data: list[dict] = queries.SELECT_ALL_FROM_RecipesIngredients_WHERE_Recipes_id(Recipe_id,
		  ignore=["is_deleted"])
		[ingredient.update({"Ingredients_id": ingredient.pop("Ingredients.id")}) for ingredient in ingredient_data] 
		[ingredient.pop("Recipes.id") for ingredient in ingredient_data] 
		return [RecipeIngredient(**ingredient) for ingredient in ingredient_data]


	def add(self, Recipe_id: int) -> int:
		if((ingredient := queries.SELECT_ALL_FROM_Ingredients_WHERE_brand_AND_names(self._brand, self._names)) is None):
			ingredient_object = Ingredient(id=0, brand=self._brand, names=self._names, description=self._description)
			self._Ingredients_id = ingredient_object.add()
		else:
			self._Ingredients_id = ingredient["id"]

		self._id = queries.INSERT_INTO_RecipesIngredients(self._amount, self._group, self._Ingredients_id,
		  self._is_required, self._notes, self._quality, Recipe_id, self._units)

		return self._id


	def __iter__(self) -> dict:
		yield from {
			"id": self._id,
			"Ingredients_id": self._Ingredients_id,
			"group": self._group,
			"amount": float(self._amount),
			"units": self._units,
			"quality": self._quality,
			"is_required": self._is_required,
			"notes": self._notes,
			"brand": self._brand,
			"names": self._names,
			"description": self._description,
		}.items()


	def __repr__(self) -> str:
		return str(self)


	def __str__(self) -> str:
		return json.dumps(dict(self), indent=4)


	def id(self) -> int:
		return self._id


	def ingredient(self) -> Ingredient:
		return self.Ingredient


	def group(self) -> int:
		return self._group


	def amount(self) -> int:
		return self._amount


	def units(self) -> int:
		return self._units


	def quality(self) -> str:
		return self._quality


	def is_required(self) -> bool:
		return self._is_required


	def notes(self) -> str:
		return self._notes


	# ——————————————————————————————————————————————————— SPECIAL  ——————————————————————————————————————————————————— #

	def __mul__(self, amount: int|float|Decimal) -> RecipeIngredient:
		if(isinstance(amount, float)):
			amount = Decimal(amount)

		amount *= self._amount

		return RecipeIngredient(id=self._id, brand=self._brand, names=self._names, description=self._description,
		  group=self._group, amount=amount, units=self._units, quality=self._quality, is_required=self._is_required,
		  notes=self._notes, Ingredients_id=self._Ingredients_id)


	def __rmul__(self, amount: int|float|Decimal) -> RecipeIngredient:
		if(isinstance(amount, float)):
			amount = Decimal(amount)

		return self * amount


	def __imul__(self, amount: int|float|Decimal) -> None:
		if(isinstance(amount, float)):
			amount = Decimal(amount)

		self._amount *= amount

		return self


	# ————————————————————————————————————————————— CONTEXTED INGREDIENT ————————————————————————————————————————————— #

	def name(self, amount: Decimal|None=None) -> int:
		if(amount is None):
			amount = self._amount

		return self._names[self._units == ["", ""] and amount.as_integer_ratio()[0] > 1.0]


	def unit(self, amount: Decimal|None=None) -> int:
		if(amount is None):
			amount = self._amount

		return self._units[amount.as_integer_ratio()[0] > 1]
