FROM python:3.11.4-slim-buster as builder
WORKDIR /build/

COPY pyproject.toml README.md /build/
COPY app/ /build/app/
COPY README.md /build/
COPY pyproject.toml /build/

RUN python -m pip install --upgrade pip
RUN pip install /build/
RUN rm -rf /build/

FROM python:3.11.4-slim-buster as app

COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/

CMD python -m app.app

# FROM app as personal_app
# docker build . -t your-repo/chat-gpt-in-slack
# export SLACK_APP_TOKEN=xapp-...
# export SLACK_BOT_TOKEN=xoxb-...
# export OPENAI_API_KEY=sk-...
# docker run -e SLACK_APP_TOKEN=$SLACK_APP_TOKEN -e SLACK_BOT_TOKEN=$SLACK_BOT_TOKEN -e OPENAI_API_KEY=$OPENAI_API_KEY -it your-repo/chat-gpt-in-slack
