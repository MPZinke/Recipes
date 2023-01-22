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


from DB import Queries


def main():
	print(Queries.SELECT_ALL_Recipes_WHERE_name("Jacket Potatoes"))
	print(Queries.SELECT_ALL_Recipes_WHERE_name("Jacket Potato"))


if(__name__ == "__main__"):
	main()
