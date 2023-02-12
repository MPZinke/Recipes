

import os
import psycopg2
import psycopg2.extras
from typing import Any



def connection_wrapper(function: callable) -> callable:
	"""
	SUMMARY: Wraps a DB function with calls to connect and closes the DB.
	PARAMS:  Takes the function that will be wrapped.
	RETURNS: The function pointer that wraps the function.
	"""
	def wrapper(*args: list, **kwargs: dict) -> Any:
		"""
		DETAILS: Creates a connection and passes it to the calling function.
		RETURNS: Value(s) if values.
		THROWS:  Whatever exceptions occur during function call.
		"""
		DB_user: str = os.getenv("RECIPES_DB_USER")
		DB_host: str = os.getenv("RECIPES_DB_HOST")
		DB_password: str = os.getenv("RECIPES_DB_PASSWORD")

		connection_string = f"host={DB_host} dbname=Recipes user={DB_user} password={DB_password}"
		with psycopg2.connect(connection_string) as connection:
			connection.autocommit = True  # Automatically commit changes to DB
			with connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
				return function(cursor, *args, **kwargs)

	wrapper.__name__ = function.__name__
	return wrapper


@connection_wrapper
def query(cursor, recipe_name: str, *ingredients: list) -> list[dict]:
	ingredient_dictionaries = []
	for ingredient in ingredients:
		query = f"""SELECT *
			FROM "RecipesIngredients"
			JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
			JOIN "Recipes" ON "RecipesIngredients"."Recipes.id" = "Recipes"."id"
			WHERE %s = ANY("Ingredients"."names")
			  AND "Recipes"."name" = %s
		"""
		cursor.execute(query, (ingredient, recipe_name))
		ingredient_dictionaries += [dict(ingredient) for ingredient in cursor]

	return ingredient_dictionaries


def to_special(recipe_ingredient: dict) -> str:
	amount_tuple = f"""\\"amount\\": {recipe_ingredient["amount"]}"""
	quality_tuple = f"""\\"quality\\": \\"{recipe_ingredient["quality"]}\\\""""
	units_tuple = f"""\\"units\\": [\\"{recipe_ingredient["units"][0]}\\", \\"{recipe_ingredient["units"][1]}\\"]"""
	name_tuple = f"""\\"name\\": \\"{recipe_ingredient["names"][0]}\\\""""

	tuples = {"amount": amount_tuple, "quality": quality_tuple, "names": name_tuple}
	valid_tuples = [value for key, value in tuples.items() if(recipe_ingredient[key])]
	if(recipe_ingredient["units"][0] or recipe_ingredient["units"][1]):
		valid_tuples.insert(-1, units_tuple)
	return f"""${{quantity::\\\\{{{", ".join(valid_tuples)}\\\\}}}}"""


def main():
	recipe_ingredients: list[dict] = query("Honey Garlic Chicken", "Egg", "Corn Starch", "Sesame Oil", "Chicken Breast")
	for recipe_ingredient in recipe_ingredients:
		print(to_special(recipe_ingredient))


if(__name__ == "__main__"):
	main()
