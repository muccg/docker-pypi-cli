#
# docker run --rm \
#            --interactive \
#            --tty \
#            muccg/pypicli
#
FROM python:3.6-alpine
LABEL maintainer "https://github.com/muccg/"

ARG ARG_PYPICLI_VERSION

ENV VIRTUAL_ENV /env
ENV PIP_NO_CACHE_DIR="off"
ENV PYTHON_PIP_VERSION 9.0.1
ENV PYTHONIOENCODING=UTF-8
ENV PYPICLI_VERSION $ARG_PYPICLI_VERSION

RUN apk --no-cache add \
    ca-certificates \
    groff \
    less

RUN python3.6 -m venv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade \
    pip==$PYTHON_PIP_VERSION \
    pypi-cli==$ARG_PYPICLI_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN addgroup -g 1000 pypi \
  && adduser -D -h /data -H -S -u 1000 -G pypi pypi \
  && mkdir /data \
  && chown pypi:pypi /data

USER pypi

ENTRYPOINT ["/env/bin/pypi"]
