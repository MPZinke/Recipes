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


from DB.Connection import connection_wrapper


@connection_wrapper
def SELECT_ALL_FROM_Recipes(cursor) -> list[dict]:
	query: str = """
		SELECT *
		FROM "Recipes"
		WHERE "is_deleted" = FALSE;
	"""
	cursor.execute(query)
	return [recipe for recipe in cursor]


@connection_wrapper
def SELECT_ALL_FROM_Recipes_WHERE_id(cursor, id: int) -> dict | None:
	query: str = """
		SELECT *
		FROM "Recipes"
		WHERE "id" = %s
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (id,))
	return next(cursor, None)


@connection_wrapper
def SELECT_ALL_FROM_Recipes_WHERE_name(cursor, name: str) -> dict | None:
	query: str = """
		SELECT *
		FROM "Recipes"
		WHERE "name" = %s
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (name,))
	return next(cursor, None)


@connection_wrapper
def SELECT_ALL_FROM_RecipesIngredients_WHERE_Recipes_id(cursor, Recipe_id: int) -> list[dict]:
	query: str = """
		SELECT *
		FROM "RecipesIngredients"
		JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
		WHERE "RecipesIngredients"."Recipes.id" = %s
		  AND "RecipesIngredients"."is_deleted" = FALSE
		ORDER BY "RecipesIngredients"."is_required" DESC;
	"""
	cursor.execute(query, (Recipe_id,))
	return [recipe_ingredient for recipe_ingredient in cursor]


@connection_wrapper
def SELECT_ALL_FROM_RecipesIngredients_WHERE_Ingredients_name(cursor, Ingredients_name: str) -> dict | None:
	query: str = """
		SELECT *
		FROM "RecipesIngredients"
		JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
		WHERE %s = ANY("Ingredients"."names")
		  AND "RecipesIngredients"."is_deleted" = FALSE;
	"""
	cursor.execute(query, (Ingredients_name,))
	return next(cursor, None)


@connection_wrapper
def SELECT_ALL_FROM_Ingredients_WHERE_name(cursor, name: str) -> dict | None:
	query: str = """
		SELECT *
		FROM "Ingredients"
		WHERE %s = ANY("names")
		  AND "is_deleted" = FALSE;
	"""
	cursor.execute(query, (name,))
	return next(cursor, None)


@connection_wrapper
def SELECT_Recipes_name_FROM_RecipesIngredients_WHERE_Ingredients_name(cursor, Ingredients_name: str) -> list[dict]:
	query: str = """
		SELECT "Recipes"."name"
		FROM "RecipesIngredients"
		JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
		JOIN "Recipes" ON "RecipesIngredients"."Recipes.id" = "Recipes"."id"
		WHERE %s = ANY("Ingredients"."names")
		  AND "RecipesIngredients"."is_deleted" = FALSE;
	"""
	cursor.execute(query, (Ingredients_name,))
	return [recipe_name for recipe_name in cursor]
