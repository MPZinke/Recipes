

from typing import TypeVar


from DB import Queries


RecipeIngredient = TypeVar("Recipe");


class RecipeIngredient:
	def __init__(self, *, id: int, is_deleted: bool, brand: str, name: str, description: str, amount: int,
	  quantity: str, is_required: bool, notes: str, Ingredients_id: int):
		self._id: int = id
		self._brand: str = brand
		self._name: str = name
		self._description: str = description
		self._amount: int = amount
		self._quantity: str = quantity
		self._is_required: bool = is_required
		self._notes: str = notes
		self._Ingredients_id: int = Ingredients_id


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
