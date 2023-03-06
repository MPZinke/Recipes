

from flask import render_template


from Classes import Ingredient
from DB import Queries


def GET_ingredients():
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("Ingredients/Index.j2", title="Ingredients", ingredients=ingredients)


def GET_ingredients_search(search: str):
	print(f"%{search}%")
	ingredients: list[Ingredient] = Ingredient.search(f"%{search}%")
	return render_template("Ingredients/Index.j2", title="Ingredients", ingredients=ingredients)


def GET_ingredient(ingredient_name: str):
	ingredient: Ingredient = Ingredient.from_name(ingredient_name)
	recipe_names: list[str] = Queries.SELECT_Recipes_name_FROM_RecipesIngredients_WHERE_Ingredients_name(ingredient_name)
	return render_template("Ingredient/Index.j2", title=ingredient.names()[0], ingredient=ingredient,
	  recipe_names=recipe_names)
