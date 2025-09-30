FROM python:3.9-alpine
WORKDIR /test_api
COPY tests/authentication/test_authentication.py /test_api/
RUN python -m pip install --upgrade pip && pip install requests
CMD ["python", "test_authentication.py"]
