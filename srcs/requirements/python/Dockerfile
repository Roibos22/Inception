FROM python

WORKDIR /app

COPY requirements/python/requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
