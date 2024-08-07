FROM akito13/nim:2.0.8-alpine

RUN apk update

{{#deps}}
  RUN apk add {{{.}}}
{{/deps}}

## set working directory
WORKDIR /usr/src/app

## Nim environment
ENV NIM_ENV=production
ENV NIMBLE_DIR=/home/nim/.nimble
ENV PATH=$PATH:/home/nim/.nimble/bin


{{#files}}
  COPY '{{source}}' '{{target}}'
{{/files}}

ENV PATH $PATH:/root/.nimble/bin

{{#build_with}}
  RUN {{{.}}}
{{/build_with}}
{{^build_with}}
  RUN nimble install -y
{{/build_with}}

{{#build_command}}
  RUN {{{.}}}
{{/build_command}}
{{^build_command}}
  RUN nim c {{#build_opts}} {{{.}}} {{/build_opts}} \
    --assertions:off \
    --warnings:off \
    --hints:off \
    -d:release \
    --opt:speed \
    --passC:-flto \
    --passL:-flto \
    server.nim
{{/build_command}}

FROM alpine:latest

WORKDIR /usr/src/app

RUN apk update

RUN apk add openssl-dev pcre-dev

{{#custom_files}}
  COPY --from=0 /usr/src/app/{{{.}}} /usr/src/app/{{{.}}}
{{/custom_files}}
{{^custom_files}}
  COPY --from=0 /usr/src/app/server /usr/src/app/server
{{/custom_files}}

{{#command}}
  CMD {{{.}}}
{{/command}}
{{^command}}
  CMD /usr/src/app/server
{{/command}}
