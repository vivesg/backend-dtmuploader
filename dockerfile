FROM python:3

LABEL Author="German Vives"
LABEL E-mail="german.vives@microsoft.com"
LABEL version="0.0.1"

ENV PYTHONDONTWRITEBYTECODE 1
ENV FLASK_APP "app.py"
ENV FLASK_ENV "production"
ENV FLASK_DEBUG True

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
EXPOSE 5000

CMD flask run --host=0.0.0.0