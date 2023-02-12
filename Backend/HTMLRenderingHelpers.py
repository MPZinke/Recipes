

from datetime import timedelta
from decimal import Decimal
from flask import request
import json
import re


def format_decimal(value: Decimal, precission: str=".00") -> str:
	return value.quantize(Decimal(precission))


def format_decimal_fractionally(value: Decimal) -> str:
	if(isinstance(value, int)):
		return str(value)

	integer_value = int(value)
	decimal_value = (value % Decimal("1.0")).quantize(Decimal(".00"))

	fractions = {Decimal("0.5"): "½", Decimal("0.33"): "⅓", Decimal("0.67"): "⅔", Decimal("0.25"): "¼",
	  Decimal("0.75"): "¾", Decimal("0.125"): "⅛", Decimal("0.375"): "⅜", Decimal("0.0"): ""}
	if(decimal_value in fractions):
		integer_value_str = str(integer_value) if(integer_value) else ""
		return f"{integer_value_str}{fractions[decimal_value]}"

	return str(round(value, 2))


def _extract_data(argument: str, line: str) -> list[str]:
	# FROM: https://wordaligned.org/articles/string-literals-and-regular-expressions
	data_regex = rf"""\${{{argument}::(?P<data>(?:[^{{}}\\]|\\.)*)}}"""
	data: list[str] = re.findall(data_regex, line)
	unescaped_data: list[str] = [re.sub(r"""\\(?P<character>.)""",r"""\g<character>""", string) for string in data]
	return unescaped_data


def _replace_data(argument: str, line: str, replacement: str) -> str:
	data_regex = rf"""\${{{argument}::(?:[^{{}}\\]|\\.)*}}"""
	replacee: str = next(iter(re.findall(data_regex, line)))

	return line.replace(replacee, replacement)


def replace_special(line: str) -> str:
	"""
	SUMMARY: Converts a timer tag in a line into a link to the timer endpoint.
	PARAMS:  Takes the line to search through and replace.
	DETAILS: Uses a regex to determine the timer tags. For each tag, the duration is converted to a spelled out version
	         link to the timer endpoint.
	RETURNS: A version of the line with tags replaced with links
	"""
	line = replace_quantity(line)
	line = replace_timer(line)
	return replace_title(line)


def replace_quantity(line: str) -> str:
	"""
	`{"amount": X.X, "unit": "...", "quality": "...", "name": "..."}`
	"""
	if(len(ingredient_jsons := _extract_data("quantity", line)) == 0):
		return line

	multiplier: Decimal = Decimal(request.args.get("multiplier", "1.0"))

	for ingredient in ingredient_jsons:
		ingredient_json: dict = json.loads(ingredient)
		keys_and_defaults = {"amount": 0.0, "units": ["", ""], "quality": "", "name": ""}
		amount, units, quality, name = [ingredient_json.get(key, default) for key, default in keys_and_defaults.items()]

		amount_str: str = format_decimal_fractionally(Decimal(amount) * multiplier)
		unit: str = units[(Decimal(amount) * multiplier).as_integer_ratio()[0] > 1]
		link = f"""<span class="tooltip" title="{amount_str} {unit} {quality}">{name}</span>"""

		line = _replace_data("quantity", line, link)

	return line


def replace_timer(line: str) -> str:
	"""
	SUMMARY: Converts a timer tag in a line into a link to the timer endpoint.
	PARAMS:  Takes the line to search through and replace.
	DETAILS: Uses a regex to determine the timer tags. For each tag, the duration is converted to a spelled out version
	         link to the timer endpoint.
	RETURNS: A version of the line with tags replaced with links
	"""
	if(len(durations := _extract_data("timer", line)) == 0):
		return line

	for duration in durations:
		hours, minutes, seconds = [int(value) for value in duration.split(":")]
		time_values = {unit: value for unit, value in {"Hours": hours, "Minutes": minutes, "Seconds": seconds}.items()}
		time_values = {unit if(value > 1) else unit[:-1]: value for unit, value in time_values.items()}
		duration_text = " ".join([f"{value} {unit}" for unit, value in time_values.items() if(value)])

		link = f"""<a href="/timer/{duration}" target="_blank">{duration_text}</a>"""
		line = _replace_data("timer", line, link)

	return line


def replace_title(line: str) -> str:
	"""
	`{"title": "...", "text": "..."}`
	FROM: https://stackoverflow.com/a/7503251
	"""
	if(len(title_jsons := _extract_data("title", line)) == 0):
		return line

	for title_json in title_jsons:
		title, text = [json.loads(title_json)[key] for key in ["title", "text"]]
		link = f"""<span class="tooltip" title="{title}">{text}</span>"""
		line = _replace_data("title", line, link)

	return line
