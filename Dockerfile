FROM python:3.8-slim

WORKDIR /app

COPY ./app /app

RUN pip install --trusted-host pypi.python.org Flask

EXPOSE 80

CMD ["python", "app.py"]
