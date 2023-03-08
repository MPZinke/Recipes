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


from flask import render_template
import uuid


from Backend.Classes import Ingredient, RecipeIngredient


def GET_new_recipe():
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("New/Recipe/Index.j2", title="New Recipe", ingredients=ingredients)


def POST_new():
	return "Posty McPostface"


def GET_new_recipe_ingredient():
	ingredient = RecipeIngredient(id=0, brand="", names=["Test Ingredient", "Test Ingredients"], description="Test",
	  group="", amount=1.0, units=["Unit", "Units"], quality="Testful", is_required=False, notes="This is a test",
	  Ingredients_id=0)
	return render_template("New/RecipeIngredient/New.j2", uuid=uuid.uuid4(), ingredient=ingredient)


def GET_new_instruction_section():
	return render_template("New/Instruction/Section.j2")


def GET_new_instruction_section_dictionary():
	return render_template("New/Instruction/SectionDictionary.j2")


def GET_new_instruction_step():
	return render_template("New/Instruction/Step.j2")


def GET_new_instruction_step_section(section: str):
	return render_template("New/Instruction/Step.j2", section=section)


def GET_new_instruction_step_list():
	return render_template("New/Instruction/StepList.j2")
