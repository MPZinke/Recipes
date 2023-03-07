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


from flask import Flask, request
from typing import Any, Dict


ALLOWED_METHODS = ["CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "TRACE"]


def add_url(app: Flask, url: str, GET: callable=None, **methods: Dict[str, callable]) -> None:
	def method_function(*args: list[Any], **kwargs: Dict[str, Any]) -> Any:
		return {method.upper(): function for method, function in methods.items()}[request.method](*args, **kwargs)

	# Ensure all methods are correct HTTP methods.
	if((bad_methods := "', '".join([method for method in methods if(method.upper() not in ALLOWED_METHODS)])) != ""):
		raise Exception(f"Method(s) '{bad_methods}' not an HTTP method for URL '{url}'")

	if(GET is not None):  # Use the GET argument
		if("GET" in [key.upper() for key in methods]):  # Ensure 'GET' is not doubly supplied
			raise Exception(f"Ambiguous supplying of argument 'GET' and keyword argument 'GET' for URL '{url}'")

		methods["GET"] = GET

	if(len(methods) == 0):  # Ensure at least 1 method supplied
		raise Exception(f"At least one HTTP method must be supplied for URL '{url}")

	for method, function in methods.items():  # Ensure all methods have a callback
		if(not hasattr(function, '__call__')):
			raise Exception(f"Method '{method}' arg must be of type 'callable', not '{type(function)}' for URL '{url}'")

	# Set URLs for both urls that do and do not end with '/', with the exception of the root URL
	urls = set(url for url in [url.rstrip("/"), f"{url}/" if(url[-1] != "/") else url] if(url))
	[app.add_url_rule(url, url, method_function, methods=list(methods)) for url in urls]
