# see versions at https://hub.docker.com/_/ghost
FROM ghost:5.14.1

WORKDIR /var/lib/ghost

# Ghost に必要なファイルをコピー（config.template.json など）
COPY . .

# パスワードをテンプレートに埋め込んで config.production.json を作成
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > /var/lib/ghost/config.production.json

# Ghost 起動前に knex-migrator init を自動実行する
RUN npx knex-migrator init || echo "Migration already done or failed safely."

ENTRYPOINT []
CMD ["node", "current/index.js"]
