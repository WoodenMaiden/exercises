FROM python:latest

WORKDIR /app

COPY app .
RUN pip3 install -r requirements.txt

CMD [ "python3", "-m" , "quart", "--app", "main", "run", "--host=0.0.0.0", "--port=80" ]