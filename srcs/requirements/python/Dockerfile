# Use the appropriate package manager for Debian
FROM debian:buster

# Set the working directory
WORKDIR /app

# Install Python 3 and development tools using apt-get
RUN apt-get update && apt-get install -y python3 python3-dev

# Copy requirements file
COPY ../srcs/requirements/python/requirements.txt .

# Install Python 3 and development tools using apt-get
RUN apt-get update && apt-get install -y python3 python3-dev

# Install pip (package manager for Python)
RUN apt-get install -y python3-pip

RUN pip3 install Flask

# Copy your application files
COPY . .

# Define the command to run your application
CMD ["python3", "app.py"]  # Use 'python3' for Debian