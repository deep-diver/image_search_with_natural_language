FROM pytorch/pytorch:latest
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .   
ENV PIXABAY_API_KEY="22176616-358d1b190a298ff59f96b35a1"
EXPOSE 8080
CMD ["gunicorn", "-b 8080", "-t 60", "main:app"]
