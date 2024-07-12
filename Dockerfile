FROM python:3.12-slim

RUN apt-get update --fix-missing \
  && apt-get install -y --no-install-recommends \
  curl \
  && rm -rf /var/lib/apt/lists/*

ARG SFAPI_VERSION

COPY requirements-common.txt /requirements-common.txt
COPY requirements-${SFAPI_VERSION}.txt /requirements.txt

RUN pip install -r /requirements-common.txt
RUN pip install -r /requirements.txt

WORKDIR /app
COPY src .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]
