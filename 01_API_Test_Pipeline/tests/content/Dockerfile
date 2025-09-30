FROM python:3.9-alpine
WORKDIR /test_api
COPY tests/content/test_content.py .
RUN python -m pip install --upgrade pip && pip install requests
CMD ["python", "test_content.py"]
