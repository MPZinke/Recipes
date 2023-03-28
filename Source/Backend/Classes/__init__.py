#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.02.15                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


from Backend.Classes.Ingredient import Ingredient
from Backend.Classes.RecipeIngredient import RecipeIngredient
from Backend.Classes.Recipe import Recipe


def validate_keys(definition: str, values: dict, types: dict) -> None:
	if((missing_keys := [key for key in types if(key not in values)])):
		raise KeyError(f"""Key(s) '{"', '".join(missing_keys)}' is missing from '{definition}' definition""")

	if((unknown_keys := [key for key in values if(key not in types)])):
		raise KeyError(f"""Unknown key(s) '{"', '".join(unknown_keys)}'""")

	for key, type in types.items():
		if(not isinstance(values[key], type)):
			raise ValueError(f"""Key '{key}' must be of type '{type}'""")


def validate_list(key: str, values: list, type: type) -> None:
	if(any(not isinstance(time, type) for time in values)):
		raise ValueError(f"""Values for '{key}' must be of type 'list[{type.__name__}]'""")
