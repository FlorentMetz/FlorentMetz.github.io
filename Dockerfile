FROM ruby:2.3

COPY . /jekyll-blog
WORKDIR /jekyll-blog

EXPOSE 4000

RUN bundler install
ENTRYPOINT jekyll serve -w -H 0.0.0.0 -P 4000
