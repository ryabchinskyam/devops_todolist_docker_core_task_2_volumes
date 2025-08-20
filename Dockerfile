# Шар 1: builder
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && pip install --prefix=/install -r requirements.txt

COPY . .


# Шар 2: final
FROM python:3.11-slim AS final

WORKDIR /app

COPY --from=builder /install /usr/local

COPY --from=builder /app /app

ENV PYTHONUNBUFFERED=1

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

