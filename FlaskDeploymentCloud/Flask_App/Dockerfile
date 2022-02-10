FROM python:3.8

RUN apt update

RUN apt install python3 python3-pip python3-venv -y

RUN mkdir /opt/basic_movie_db

COPY /basic_movie_db /opt/basic_movie_db

WORKDIR /opt/basic_movie_db

RUN pip3 install -r requirements.txt

RUN python3 create.py

ENTRYPOINT ["python3", "app.py"]
