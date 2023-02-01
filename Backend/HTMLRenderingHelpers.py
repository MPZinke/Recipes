

from datetime import timedelta
import re


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
