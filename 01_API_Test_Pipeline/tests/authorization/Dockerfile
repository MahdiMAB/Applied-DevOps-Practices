FROM python:3.9-alpine
WORKDIR /test_api
COPY tests/authorization/test_authorization.py . 
RUN python -m pip install --upgrade pip && pip install requests
CMD ["python", "test_authorization.py"]
