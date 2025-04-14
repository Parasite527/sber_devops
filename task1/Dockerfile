FROM python:3.12-slim

WORKDIR /app

COPY app.py /app/app.py

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/logs /app/config

ENV APP_PORT=5000
ENV LOG_LEVEL=INFO
ENV WELCOME_MSG="Welcome to the custom app"

EXPOSE ${APP_PORT}

CMD [ "python", "app.py" ]