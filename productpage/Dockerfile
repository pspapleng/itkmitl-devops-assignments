FROM python:3.7.11-stretch 

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "productpage.py", "9080" ]