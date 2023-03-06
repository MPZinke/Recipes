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
		upper_methods = {method.upper(): function for method, function in methods.items()}
		return upper_methods[request.method.upper()](*args, **kwargs)

	for method in methods:
		if(method.upper() not in ALLOWED_METHODS):
			raise Exception(f"Method '{method.upper()}' not an HTTP method for URL '{url}'")

	if(GET is not None and not hasattr(GET, '__call__')):
		raise Exception(f"If supplied, argument GET must be of type 'callable', not '{type(GET)}' for URL '{url}'")

	if(GET is not None and "GET" in [key.upper() for key in methods]):
		raise Exception(f"Ambiguous supplying of argument 'GET' and keyword argument 'GET' for URL '{url}'")

	if(GET is not None):
		methods["GET"] = GET

	if(len(methods) == 0):
		raise Exception(f"At least one HTTP method must be supplied for URL '{url}")

	urls = set(url for url in [url.rstrip("/"), f"{url}/" if(url[-1] != "/") else url] if(url))
	[app.add_url_rule(url, url, method_function, methods=list(methods)) for url in urls]
