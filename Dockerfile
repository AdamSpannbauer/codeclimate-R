FROM alpine:edge

LABEL maintainer "Adam Spannbauer <spannbaueradam@gmail.com>"

WORKDIR /usr/src/app

RUN adduser -u 9000 -D app

RUN apk add --no-cache bash
RUN apk add --no-cache R R-dev

RUN Rscript -e "install.packages(c('lintr', 'jsonlite'), repos = 'http://cran.us.r-project.org')"
RUN rm -rf /tmp/*

COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/codeclimate-R"]
