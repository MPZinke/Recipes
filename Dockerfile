FROM python:3.11


COPY ./ /usr/local/bin/Recipes
WORKDIR /usr/local/bin/Recipes


RUN pip3 install mpzinke psycopg2


ENTRYPOINT ["python3", "Main.py"]
