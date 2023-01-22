
import os
# https://stackoverflow.com/a/73626299 pip3 install psycopg2-binary --force-reinstall --no-cache-dir
import psycopg2
import psycopg2.extras
from typing import Any, Set, Union




def connection_wrapper(function: callable) -> callable:
	"""
	SUMMARY: Wraps a DB function with calls to connect and closes the DB.
	PARAMS:  Takes the function that will be wrapped.
	RETURNS: The function pointer that wraps the function.
	"""
	def wrapper(*args: list, **kwargs: dict) -> Any:
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
				return function(cursor, *args, **kwargs)

	wrapper.__name__ = function.__name__
	return wrapper
