#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-
__author__ = "MPZinke"

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on 2023.03.06                                                                                                      #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


from pathlib import Path


from flask import Blueprint


from frontend.endpoints import ingredients
from frontend.endpoints import new
from frontend.endpoints import recipes


ROOT_DIR = Path(__file__).absolute().parent
TEMPLATE_FOLDER = ROOT_DIR / "frontend/Templates"
STATIC_FOLDER = ROOT_DIR / "frontend/Static"
BLUEPRINT = Blueprint("recipes", __name__, template_folder=TEMPLATE_FOLDER, static_folder=STATIC_FOLDER)


@BLUEPRINT.route("/favicon.ico")
def GET_favicon_icon():
	return ""
