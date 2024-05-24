FROM alpine:3.18

WORKDIR /app

RUN apk add --update python3 python3-dev
RUN apk add --update py3-pip  # OR py3-pip (depending on your Alpine version)

COPY ../srcs/requirements/python/requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python3", "app.py"]  # Use 'python3' for Alpine
