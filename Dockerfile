FROM python:3.12.12-slim

WORKDIR /opt/api

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

ENTRYPOINT ["python", "app/main.py"]
#CMD ["python", "app/main.py"] # arquitectura monolitica
