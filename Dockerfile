FROM rocker/rstudio:latest

LABEL maintainer "Adam Spannbauer <spannbaueradam@gmail.com>"

WORKDIR /usr/src/app

RUN R -e "install.packages(c('lintr', 'jsonlite'), repos = 'http://cran.us.r-project.org')"

RUN adduser -u 9000 --disabled-login app
COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/codeclimate-R"]
