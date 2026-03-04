<<<<<<< HEAD
FROM python:3.12.12-slim

WORKDIR /opt/api

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

ENTRYPOINT ["python", "app/main.py"]
#CMD ["python", "app/main.py"] # arquitectura monolitica
=======
FROM python:3.12.12-slim AS builder

WORKDIR /opt/api

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.12.12-slim AS runner

COPY --from=builder /opt/api /opt/api

ENV PATH=""

COPY App/main.py /opt/api/main.py

EXPOSE 8000

ENTRYPOINT ["python", "app/main.py"]
>>>>>>> fe4a533 (Add container arquitecture in the proyect)
