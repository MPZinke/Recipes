

run:
	python3 Backend/Main.py


install:
	brew install postgresql
	brew services start postgresql
	pip3 install flask psycopg2


database:
	psql Recipes -f DB/Schema.sql
	for FILE in DB/Recipes/*.sql; do \
		psql Recipes -f "$${FILE}" ; \
	done