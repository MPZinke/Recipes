

from pathlib import Path


from flask import Blueprint, render_template


from backend.classes import Ingredient
from backend.db import queries


ROOT_DIR = Path(__file__).absolute().parent.parent
TEMPLATE_FOLDER = ROOT_DIR / "Frontend/Templates"
STATIC_FOLDER = ROOT_DIR / "Frontend/Static"
BLUEPRINT = Blueprint("ingredients", __name__, template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)


@BLUEPRINT.route("/ingredients")
def ingredients():
	"""Gets all ingredients & displays them as a webpage."""
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("Ingredients/Index.j2", title="Ingredients", ingredients=ingredients)


@BLUEPRINT.route("/ingredients/<string:search>")
def ingredients_search(search: str):
	"""Gets all ingredients matching a search & displays them as a webpage."""
	ingredients: list[Ingredient] = Ingredient.search(f"%{search}%")
	return render_template("Ingredients/Index.j2", title="Ingredients", ingredients=ingredients)


@BLUEPRINT.route("/ingredient/<string:ingredient_name>")
def ingredient(ingredient_name: str):
	"""Gets a specific ingredient & displays it as a webpage."""
	ingredient: Ingredient = Ingredient.from_name(ingredient_name)
	recipe_names: list[str] = queries.SELECT_Recipes_name_FROM_RecipesIngredients_WHERE_Ingredients_name(ingredient_name)
	return render_template("Ingredient/Index.j2", title=ingredient.names()[0], ingredient=ingredient,
	  recipe_names=recipe_names)
