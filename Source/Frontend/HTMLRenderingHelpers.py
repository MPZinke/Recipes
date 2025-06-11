

from datetime import timedelta
from decimal import Decimal
from flask import request
import json
import re


import mpzinke


def format_decimal(value: Decimal, precission: str=".00") -> str:
	return value.quantize(Decimal(precission))


def format_decimal_fractionally(value: int|float|Decimal) -> str:
	if(isinstance(value, int)):
		return str(value)

	if(isinstance(value, float)):
		value = Decimal(value)

	integer_value = int(value)
	decimal_value = (value % Decimal("1.0")).quantize(Decimal(".000"))

	fractions = {Decimal("0.5"): "½", Decimal("0.33"): "⅓", Decimal("0.67"): "⅔", Decimal("0.25"): "¼",
	  Decimal("0.75"): "¾", Decimal("0.125"): "⅛", Decimal("0.375"): "⅜", Decimal("0.0"): ""}
	if(decimal_value in fractions):
		integer_value_str = str(integer_value) if(integer_value) else ""
		return f"{integer_value_str}{fractions[decimal_value]}"

	return str(round(value, 2))


def render_value(server: mpzinke.Server):
	def render_value(value: str):
		template = server.jinja_env.from_string(value)
		return template.render(request=request)

	return render_value
