FROM python:latest

ENV QUART_ENV=development
ENV QUART_DEBUG=true

WORKDIR /app

COPY app .
RUN pip3 install -r requirements.txt

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "python3", "-m" , "quart", "--app", "main", "run", "--host=0.0.0.0", "--port=80" ]
