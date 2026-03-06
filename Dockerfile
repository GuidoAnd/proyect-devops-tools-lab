FROM python:3.12.12-slim

WORKDIR /opt/api

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/main.py .

EXPOSE 8000

ENTRYPOINT ["python", "/opt/api/main.py"]
# CMD ["python", "app/main.py"]