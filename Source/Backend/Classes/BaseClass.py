#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.03.31                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


import types
import typing
from typing import Any, Dict


class BaseClass:
	@staticmethod
	def check_type(value: Any, needed_type: type) -> bool:
		"""
		https://stackoverflow.com/questions/49171189/whats-the-correct-way-to-check-if-an-object-is-a-typing-generic
		"""
		check_type = BaseClass.check_type
		# int|str
		if((origin := typing.get_origin(needed_type)) is types.UnionType or origin is typing.Union):
			return any(BaseClass.check_type(value, unioned_type) for unioned_type in needed_type.__args__)

		# list[<__args__[0]>] or Dict[<__args__[0]>, <__args__[1]]
		elif(isinstance(needed_type, (types.GenericAlias, typing._GenericAlias))):
			if(not isinstance(value, typing.get_origin(needed_type))):  # if(not isinstance({1: ['1', '1'], ...}, dict))
				return False

			# if the number of types for the generic is one, iterate through those types
			if(len((generics_args := needed_type.__args__)) == 1):
				return all(BaseClass.check_type(subvalue, generics_args[0]) for subvalue in value)

			# {1: ['1', '1'], 2: ['2', '2'], 3: ['3', '3']}
			for value_children in (value.items() if(isinstance(value, dict)) else value):
				# (1, int), (['1', '1'], list[str])
				if(any(not check_type(grandchild, type) for grandchild, type in zip(value_children, generics_args))):
					return False

			return True

		# int
		return isinstance(value, needed_type)


	def validate(self, params: Dict[str, type], values: Dict[str, Any]) -> None:
		missing_params: Dict[str, type] = {name: type for name, type in params.items() if(name not in values)}
		if(len(missing_params) != 0):
			missing_keys_string = ", ".join([f"{name} of type '{type}'" for name, type in missing_params.items()])
			raise KeyError(f"Missing key(s) for {missing_keys_string}")

		failed_params: list[Dict[str, Any]] = []  # [{"name": "<name>", "required_type": <type>, "value_type": <value>}]
		for name, required_type in params.items():
			if(not BaseClass.check_type(values[name], required_type)):
				failed_params.append({"name": name, "required_type": required_type, "value_type": type(values[name])})

		if(len(failed_params) == 0):
			return

		failed_param_string = "{name} must be of type '{required_type}' not '{value_type}'"
		failed_param_message = ", ".join([failed_param_string.format(**failed_param) for failed_param in failed_params])
		raise ValueError(failed_param_message)
