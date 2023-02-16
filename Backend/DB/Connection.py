
import os
# https://stackoverflow.com/a/73626299 pip3 install psycopg2-binary --force-reinstall --no-cache-dir
import psycopg2
import psycopg2.extras
from typing import Any, Set, Union


def _accept_columns(columns: str|list[str]|None, values: list|dict) -> list|dict:
	if(columns is None):
		return values

	if(isinstance(columns, str)):
		columns = [columns]

	rows = values if(isinstance(values, list)) else [values]
	remaining_values = [{key: value for key, value in row.items() if(key in columns)} for row in rows]

	return remaining_values if(isinstance(values, list)) else remaining_values[0]


def _ignore_columns(columns: str|list[str]|None, values: list|dict) -> list|dict:
	if(columns is None):
		return values

	if(isinstance(columns, str)):
		columns = [columns]

	rows = values if(isinstance(values, list)) else [values]
	remaining_values = [{key: value for key, value in row.items() if(key not in columns)} for row in rows]

	return remaining_values if(isinstance(values, list)) else remaining_values[0]


# def select_query(*, accept: str|list[str]|None=None, ignore: str|list[str]|None=None) -> callable:
# 	"""
# 	SUMMARY: Wraps a DB function with calls to connect and closes the DB.
# 	PARAMS:  Takes the function that will be wrapped.
# 	RETURNS: The function pointer that wraps the function.
# 	"""
# 	def decorator(function: callable) -> callable:
# 		def wrapper(*args: list, **kwargs: dict) -> list|dict:
# 			"""
# 			DETAILS: Creates a connection and passes it to the calling function.
# 			RETURNS: Value(s) if values.
# 			THROWS:  Whatever exceptions occur during function call.
# 			"""
# 			DB_user: str = os.getenv("RECIPES_DB_USER")
# 			DB_host: str = os.getenv("RECIPES_DB_HOST")
# 			DB_password: str = os.getenv("RECIPES_DB_PASSWORD")

# 			connection_string = f"host={DB_host} dbname=Recipes user={DB_user} password={DB_password}"
# 			with psycopg2.connect(connection_string) as connection:
# 				connection.autocommit = True  # Automatically commit changes to DB
# 				with connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
# 					results: list|dict = function(cursor, *args, **kwargs)
# 					results: list|dict = _accept_columns(accept, results)
# 					results: list|dict = _ignore_columns(ignore, results)

# 					return results

# 		wrapper.__name__ = function.__name__
# 		return wrapper

# 	return decorator


def connect(function: callable) -> callable:
	"""
	SUMMARY: Wraps a DB function with calls to connect and closes the DB.
	PARAMS:  Takes the function that will be wrapped.
	RETURNS: The function pointer that wraps the function.
	"""
	def wrapper(*args: list, accept: str|list[str]|None=None, ignore: str|list[str]|None=None, **kwargs: dict) \
	  -> list|dict:
		"""
		DETAILS: Creates a connection and passes it to the calling function.
		RETURNS: Value(s) if values.
		THROWS:  Whatever exceptions occur during function call.
		"""
		DB_user: str = os.getenv("RECIPES_DB_USER")
		DB_host: str = os.getenv("RECIPES_DB_HOST")
		DB_password: str = os.getenv("RECIPES_DB_PASSWORD")

		connection_string = f"host={DB_host} dbname=Recipes user={DB_user} password={DB_password}"
		with psycopg2.connect(connection_string) as connection:
			connection.autocommit = True  # Automatically commit changes to DB
			with connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
				results: list|dict = function(cursor, *args, **kwargs)
				results: list|dict = _accept_columns(accept, results)
				results: list|dict = _ignore_columns(ignore, results)

				return results

	wrapper.__name__ = function.__name__
	return wrapper
