FROM alpine/openssl:latest as gen_secret

RUN openssl rand -base64 12 > /secret

FROM python:latest

ENV QUART_ENV=development
ENV QUART_DEBUG=true

WORKDIR /app

COPY --from=gen_secret /secret /app/secret

COPY app .
RUN pip3 install -r requirements.txt

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "python3", "-m" , "quart", "--app", "main", "run", "--host=0.0.0.0", "--port=80" ]
