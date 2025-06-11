FROM python:3.12


COPY ./ /usr/local/bin/Recipes
WORKDIR /usr/local/bin/Recipes


RUN pip3 install flask mpzinke psycopg2


ENTRYPOINT ["python3", "."]
