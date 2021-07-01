FROM pytorch/pytorch:latest
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .   
# this information should be replaced once GitHub Action is set up
ENV PIXABAY_API_KEY="22176616-358d1b190a298ff59f96b35a1"
ENV REDIS_IN_USE="true"
ENV REDISHOST="10.195.86.155"
EXPOSE 8080
CMD [ "python3", "main.py" ]
