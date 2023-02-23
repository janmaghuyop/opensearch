# https://hub.docker.com/_/python/
FROM python:3.10.0-alpine3.14

# https://github.com/elastic/curator
# https://www.elastic.co/guide/en/elasticsearch/client/curator/current/pip.html
# https://pypi.org/project/elasticsearch-curator/#history
# https://github.com/flant/curator-opensearch

WORKDIR /escurator

COPY entrypoint.sh .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -U curator-opensearch==0.0.9 && \
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

