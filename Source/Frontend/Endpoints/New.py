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


from Backend.Classes import Ingredient


def GET_new():
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("New/Index.j2", title="New Recipe", ingredients=ingredients)


def POST_new():
	return "Posty McPostface"


def GET_new_recipe_ingredient():
	ingredients: list[Ingredient] = Ingredient.all()
	return render_template("New/RecipeIngredient/New.j2", ingredients=ingredients)


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
