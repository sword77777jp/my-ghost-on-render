# see versions at https://hub.docker.com/_/ghost
FROM ghost:5.14.1

WORKDIR $GHOST_INSTALL

# config.template.json を元に config.production.json を生成
COPY . .

# 環境変数を使ってプレースホルダーを置換
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > /var/lib/ghost/config.production.json

# Ghost公式のエントリポイントとCMDを使う（これでOK）
