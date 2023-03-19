

from decimal import Decimal
import json
from typing import TypeVar


from Backend.Classes import Ingredient
from Backend.DB import Queries


RecipeIngredient = TypeVar("Recipe");


class RecipeIngredient(Ingredient):
	def __init__(self, *, id: int, brand: str, names: list[str], description: str, group: str, amount: Decimal,
	  units: list[str], quality: str, is_required: bool, notes: str, Ingredients_id: int):
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

		recipe_ingredient_data: dict|None = Queries.SELECT_ALL_FROM_RecipesIngredients_WHERE_Ingredients_name(name,
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

		ingredient_data: list[dict] = Queries.SELECT_ALL_FROM_RecipesIngredients_WHERE_Recipes_id(Recipe_id,
		  ignore=["is_deleted"])
		[ingredient.update({"Ingredients_id": ingredient.pop("Ingredients.id")}) for ingredient in ingredient_data] 
		[ingredient.pop("Recipes.id") for ingredient in ingredient_data] 
		return [RecipeIngredient(**ingredient) for ingredient in ingredient_data]


	@staticmethod
	def validate(recipe_ingredient: dict) -> None:
		types = {
			"id": int, "group": str, "amount": float|Decimal, "units": list[str], "quality": str, "is_required": bool,
			"notes": str
		}

		if((missing_keys := [key for key in types if(key not in recipe)])):
			raise KeyError(f"""Key(s) '{"', '".join(missing_keys)}' is missing from recipe ingredient definition""")

		if((unknown_keys := [key for key in recipe if(key not in types)])):
			raise KeyError(f"""Unknown key(s) '{"', '".join(unknown_keys)}'""")

		for key, type in types.items():
			if(not isinstance(recipe[key], type)):
				raise ValueError(f"""Key '{key}' must be of type '{", ".join(type)}'""")

		Ingredient.validate({"id": recipe_ingredient["Ingredients_id"], "brand": recipe_ingredient["brand"],
		  "names": recipe_ingredient["names"], "description": recipe_ingredient["description"]})


	def __iter__(self) -> dict:
		yield from {
			"id": self._id,
			"Ingredients_id": self._Ingredients_id,
			"group": self._group,
			"amount": self._amount,
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


	def __imul__(self, amount: int|float) -> None:
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
