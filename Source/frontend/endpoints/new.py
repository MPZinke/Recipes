#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.03.07                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


from pathlib import Path


from flask import Blueprint, render_template, request


from backend.classes import Ingredient, RecipeIngredient


ROOT_DIR = Path(__file__).absolute().parent
TEMPLATE_FOLDER = ROOT_DIR / "frontend/Templates"
STATIC_FOLDER = ROOT_DIR / "frontend/Static"
BLUEPRINT = Blueprint("new", __name__, template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)


@BLUEPRINT.route("/new/recipe")
def new_recipe():
	"""Gets all ingredients & displays them as a webpage."""
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("New/Recipe/Index.j2", title="New Recipe", ingredients=ingredients)


@BLUEPRINT.route("/new/recipe/recipe_ingredient", methods=["POST"])
def new_recipe_ingredient():
	# TODO: ensure RecipeIngredient format
	section_uuid = next(iter(request.json.keys()))
	section = request.json[section_uuid]
	ingredient = RecipeIngredient(id=0, Ingredients_id=0, **section)
	return render_template("New/Recipe/RecipeIngredients/New.j2", uuid=section_uuid, ingredient=ingredient)


@BLUEPRINT.route("/new/recipe/instruction/section", methods=["POST"])
def new_instruction_section():
	# request.json = {"<uuid>": {"name": "<section name>", "instructions": {"<uuid>": "<instruction>", ...}}}
	section_uuid = next(iter(request.json.keys()))
	section = request.json[section_uuid]
	return render_template("New/Recipe/Instructions/Section/New.j2", section=section)


@BLUEPRINT.route("/new/recipe/instruction/list", methods=["POST"])
def new_instruction():
	# request.json = {"<uuid>": {"name": " name>", "instructions": {"<uuid>": "<instruction>", ...}}}
	uuid = next(iter(request.json.keys()))
	instruction = request.json[uuid]
	return render_template("New/Recipe/Instructions/List/New.j2", uuid=uuid, instruction=instruction)


def new_instruction_section():
	return render_template("New/Recipe/Instruction/Section.j2")


def new_instruction_section_dictionary():
	return render_template("New/Recipe/Instruction/SectionDictionary.j2")


def new_instruction_step():
	return render_template("New/Recipe/Instruction/Step.j2")


def new_instruction_step_section(section: str):
	return render_template("New/Recipe/Instruction/Step.j2", section=section)


def new_instruction_step_list():
	return render_template("New/Recipe/Instruction/StepList.j2")
