

from datetime import timedelta
from decimal import Decimal
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


def replace_timer(line: str) -> str:
	"""
	SUMMARY: Converts a timer tag in a line into a link to the timer endpoint.
	PARAMS:  Takes the line to search through and replace.
	DETAILS: Uses a regex to determine the timer tags. For each tag, the duration is converted to a spelled out version
	         link to the timer endpoint.
	RETURNS: A version of the line with tags replaced with links
	"""
	timer_flag_regex = r"""\$\{timer::(?P<duration>[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2})\}"""
	if(len(durations := re.findall(timer_flag_regex, line)) == 0):
		return line

	for duration in durations:
		hours, minutes, seconds = [int(value) for value in duration.split(":")]
		time_values = {unit: value for unit, value in {"Hours": hours, "Minutes": minutes, "Seconds": seconds}.items()}
		time_values = {unit if(value > 1) else unit[:-1]: value for unit, value in time_values.items()}
		duration_text = " ".join([f"{value} {unit}" for unit, value in time_values.items() if(value)])

		link = f"""<a href="/timer/{duration}" target="_blank">{duration_text}</a>"""
		line = line.replace(f"${{timer::{duration}}}", link)

	return line
