ARG PYTHON_VERSION=3.11

FROM python:${PYTHON_VERSION}-slim

RUN mkdir -p /app
WORKDIR /app/

RUN apt-get update
RUN apt-get install -y build-essential gcc

COPY README.md README.md
COPY LICENSE LICENSE
COPY tipg/ tipg/
COPY pyproject.toml pyproject.toml

RUN pip install . uvicorn --no-cache-dir
RUN rm -rf tipg/ README.md pyproject.toml LICENSE


ENV HOST 0.0.0.0
ENV PORT 5000
CMD uvicorn tipg.main:app --host ${HOST} --port ${PORT}
