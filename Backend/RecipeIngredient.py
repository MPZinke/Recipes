

from decimal import Decimal
from typing import TypeVar


from DB import Queries
from Ingredient import Ingredient


RecipeIngredient = TypeVar("Recipe");


class RecipeIngredient(Ingredient):
	def __init__(self, *, id: int, is_deleted: bool, brand: str, names: str, description: str, amount: Decimal,
	  units: list[str], quality: str, is_required: bool, notes: str, Ingredients_id: int):
		Ingredient.__init__(self, id=Ingredients_id, is_deleted=is_deleted, brand=brand, names=names,
		  description=description)
		self._id: int = id
		self._amount: Decimal = amount
		self._units: list[str] = units
		self._quality: str = quality
		self._is_required: bool = is_required
		self._notes: str = notes


	@staticmethod
	def from_Ingredient_name(name: str) -> RecipeIngredient|None:
		if(not isinstance(name, str)):
			raise Exception(f"name must be of type 'str', not type '{type(name)}'")

		recipe_ingredient_data: dict|None = Queries.SELECT_ALL_FROM_RecipesIngredients_WHERE_Ingredients_name(name)
		if(recipe_ingredient_data is None):
			return None

		recipe_ingredient_data.update({"Ingredients_id": recipe_ingredient_data.pop("Ingredients.id")})
		recipe_ingredient_data.pop("Recipes.id")

		return RecipeIngredient(**recipe_ingredient_data)


	@staticmethod
	def from_Recipe_id(Recipe_id: int) -> list[RecipeIngredient]:
		if(not isinstance(Recipe_id, int)):
			raise Exception(f"Recipe_id must be of type 'int', not type '{type(Recipe_id)}'")

		ingredient_data: list[dict] = Queries.SELECT_ALL_FROM_RecipesIngredients_WHERE_Recipes_id(Recipe_id)
		[ingredient.update({"Ingredients_id": ingredient.pop("Ingredients.id")}) for ingredient in ingredient_data] 
		[ingredient.pop("Recipes.id") for ingredient in ingredient_data] 
		return [RecipeIngredient(**ingredient) for ingredient in ingredient_data]


	def id(self) -> int:
		return self._id


	def ingredient(self) -> Ingredient:
		return self.Ingredient


	def amount(self) -> int:
		return self._amount


	def unit(self, amount: Decimal) -> int:
		return self._units[amount.as_integer_ratio()[0] > 1]


	def units(self) -> int:
		return self._units


	def quality(self) -> str:
		return self._quality


	def is_required(self) -> bool:
		return self._is_required


	def notes(self) -> str:
		return self._notes


	def name(self) -> str:
		return self._name
