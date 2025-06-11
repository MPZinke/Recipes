

from decimal import Decimal


from flask import Flask, request


def add_helpers(app: Flask):
	app.jinja_env.globals["format_decimal"] = format_decimal
	app.jinja_env.globals["format_decimal_fractionally"] = format_decimal_fractionally
	app.jinja_env.globals["render_value"] = render_value(app)

	for name, macro in app.jinja_env.get_template('Macros.j2').make_module({}).__dict__.items():
		if(not name.startswith("_")):
			app.jinja_env.globals[name] = macro


def format_decimal(value: Decimal, precission: str=".00") -> str:
	return value.quantize(Decimal(precission))


def format_decimal_fractionally(value: int|float|Decimal) -> str:
	if(isinstance(value, int)):
		return str(value)

	if(isinstance(value, float)):
		value = Decimal(value)

	integer_value = int(value)
	decimal_value = (value % Decimal("1.0")).quantize(Decimal(".000"))

	fractions = {
		Decimal("0.5"): "½",
		Decimal("0.33"): "⅓",
		Decimal("0.67"): "⅔",
		Decimal("0.25"): "¼",
		Decimal("0.75"): "¾",
		Decimal("0.125"): "⅛",
		Decimal("0.375"): "⅜",
		Decimal("0.0"): ""
	}

	if(decimal_value in fractions):
		integer_value_str = str(integer_value) if(integer_value) else ""
		return f"{integer_value_str}{fractions[decimal_value]}"

	return str(round(value, 2))


def render_value(server: Flask):
	def render_value(value: str):
		template = server.jinja_env.from_string(value)
		return template.render(request=request)

	return render_value
