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


import sys
import traceback


from flask import jsonify
from werkzeug.exceptions import HTTPException


from backend.endpoints.api import home_assistant
from backend.endpoints.api import ingredients
from backend.endpoints.api import recipe


def handle_error(error):
	"""
	SUMMARY: Handles the return response for any server error that occurs during a request.
	PARAMS:  Takes the error that has occured.
	FROM: https://readthedocs.org/projects/pallet/downloads/pdf/latest/
	 AND: https://stackoverflow.com/a/29332131
	"""
	print(error, file=sys.stderr)
	if isinstance(error, HTTPException):
		return jsonify(error=str(error)), error.code;

	try:
		exception_traceback = traceback.format_exc();
	except:
		exception_traceback = "Unknown traceback";

	return jsonify(error=str(error), traceback=exception_traceback), 500;
