FROM python:3.4.3

RUN pip install urllib3==1.10.4 && \
  pip install requests==2.7.0 && \
  pip install pysolr==3.3.2 && \
  pip install elasticsearch==1.6.0 && \
  pip install pymongo==2.8.1 && \
  pip install mongo-connector==2.0.3
