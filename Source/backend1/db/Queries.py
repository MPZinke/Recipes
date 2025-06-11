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
from typing import Any, Dict, Optional, TypeVar


from backend.db.connection import connect


Json = TypeVar("Json");


# —————————————————————————————————————————————————————— RECIPE —————————————————————————————————————————————————————— #

@connect
def SELECT_ALL_FROM_Recipes(cursor) -> list[dict]:
	query: str = """
		SELECT *
		FROM "Recipes"
		WHERE "is_deleted" = FALSE;
	"""
	cursor.execute(query)
	return list(cursor)


@connect
def SELECT_ALL_FROM_Recipes_WHERE_id(cursor, id: int) -> Optional[dict]:
	query: str = """
		SELECT *
		FROM "Recipes"
		WHERE "id" = %s
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (id,))
	return next(cursor, None)


@connect
def SELECT_ALL_FROM_Recipes_WHERE_name(cursor, name: str) -> Optional[dict]:
	query: str = """
		SELECT *
		FROM "Recipes"
		WHERE "name" = %s
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (name,))
	return next(cursor, None)


# ————————————————————————————————————————————————— RECIPEINGREDIENT ————————————————————————————————————————————————— #

@connect
def SELECT_ALL_FROM_RecipesIngredients_WHERE_Recipes_id(cursor, Recipes_id: int) -> list[dict]:
	query: str = """
		SELECT *
		FROM "RecipesIngredients"
		JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
		WHERE "RecipesIngredients"."Recipes.id" = %s
		  AND "RecipesIngredients"."is_deleted" = FALSE
		ORDER BY "RecipesIngredients"."is_required" DESC, "RecipesIngredients"."group";
	"""
	cursor.execute(query, (Recipes_id,))
	return list(cursor)


@connect
def SELECT_ALL_FROM_RecipesIngredients_WHERE_Ingredients_name(cursor, Ingredients_name: str) -> Optional[dict]:
	query: str = """
		SELECT *
		FROM "RecipesIngredients"
		JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
		WHERE %s = ANY("Ingredients"."names")
		  AND "RecipesIngredients"."is_deleted" = FALSE;
	"""
	cursor.execute(query, (Ingredients_name,))
	return next(cursor, None)


@connect
def SELECT_Recipes_name_FROM_RecipesIngredients_WHERE_Ingredients_name(cursor, Ingredients_name: str) -> list[dict]:
	query: str = """
		SELECT "Recipes"."name"
		FROM "RecipesIngredients"
		JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
		JOIN "Recipes" ON "RecipesIngredients"."Recipes.id" = "Recipes"."id"
		WHERE %s = ANY("Ingredients"."names")
		  AND "RecipesIngredients"."is_deleted" = FALSE
		GROUP BY "Recipes"."name"
		ORDER BY "Recipes"."name" ASC;
	"""
	cursor.execute(query, (Ingredients_name,))
	return [recipe["name"] for recipe in cursor]

# —————————————————————————————————————————————————— RECIPE HISTORY —————————————————————————————————————————————————— #

@connect
def SELECT_time_FROM_RecipesHistory_WHERE_Recipes_id(cursor, Recipes_id) -> list[dict]:
	query: str = """
		SELECT "time"
		FROM "RecipesHistory"
		WHERE "Recipes.id" = %s
		  AND "RecipesHistory"."is_deleted" = FALSE
		ORDER BY "time" ASC;
	"""
	cursor.execute(query, (Recipes_id,))
	return [history["time"] for history in cursor]



# ———————————————————————————————————————————————————— INGREDIENT ———————————————————————————————————————————————————— #

@connect
def SELECT_ALL_FROM_Ingredients(cursor) -> list[dict]:
	query: str = """
		SELECT *
		FROM "Ingredients"
		WHERE "is_deleted" = FALSE;
	"""
	cursor.execute(query)
	return list(cursor)


@connect
def SELECT_ALL_FROM_Ingredients_WHERE_id(cursor, id: int) -> Optional[dict]:
	query: str = """
		SELECT *
		FROM "Ingredients"
		WHERE "id" = %s
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (id,))
	return next(cursor, None)


@connect
def SELECT_ALL_FROM_Ingredients_WHERE_name(cursor, name: str) -> Optional[dict]:
	query: str = """
		SELECT *
		FROM "Ingredients"
		WHERE %s = ANY("names")
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (name,))
	return next(cursor, None)


@connect
def SELECT_ALL_FROM_Ingredients_WHERE_brand_AND_names(cursor, brand: str, names: list[str]) -> Optional[dict]:
	query: str = """
		SELECT *
		FROM "Ingredients"
		WHERE "brand" = %s
		  AND "names" = ARRAY[%s, %s]::VARCHAR(64)[2]
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (brand, names[0], names[1]))
	return next(cursor, None)


@connect
def SELECT_ALL_FROM_Ingredients_WHERE_name_like(cursor, name: str) -> list[dict]:
	query: str = """
		SELECT *
		FROM "Ingredients"
		WHERE EXISTS (
			SELECT
			FROM unnest("names") "name"
			WHERE LOWER("name") LIKE LOWER(%s)
		)
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (name,))
	return list(cursor)


@connect
def INSERT_INTO_Recipes(cursor, name: str, instructions: Json, notes: str, rating: int, servings: int,
  prep_time: timedelta, cook_time: timedelta, total_time: timedelta, url: str
) -> int:
	query = """
	INSERT INTO "Recipes" ("name", "instructions", "notes", "rating", "servings", "total_time", "prep_time",
	  "cook_time", "url"
	) VALUES
	(%s, %s, %s, %s, %s, %s, %s, %s, %s)
	RETURNING *;
	"""

	cursor.execute(query, (name, instructions, notes, rating, servings, prep_time, cook_time, total_time, url))
	return cursor.fetchone()["id"]


@connect
def INSERT_INTO_RecipesIngredients(cursor, amount: Decimal, group: str, Ingredients_id: int, is_required: bool, notes: str,
  quality: str, Recipes_id: int, units: list[str]
) -> int:
	query = """
	INSERT INTO "RecipesIngredients" ("amount", "group", "Ingredients.id", "is_required", "notes", "quality",
	  "Recipes.id", "units")
	VALUES
	(%s, %s, %s, %s, %s, %s, %s, %s)
	RETURNING *;
	"""

	cursor.execute(query, (amount, group, Ingredients_id, is_required, notes, quality, Recipes_id, units))
	return cursor.fetchone()["id"]


@connect
def INSERT_INTO_Ingredients(cursor, brand: str, names: list[str], description: str) -> int:
	query = """
	INSERT INTO "Ingredients" ("brand", "names", "description")
	VALUES
	(%s, ARRAY[%s, %s]::VARCHAR(64)[2], %s)
	RETURNING *;
	"""

	cursor.execute(query, (brand, names[0], names[1], description))
	return cursor.fetchone()["id"]
