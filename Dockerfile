FROM ghost:5.14.1

WORKDIR $GHOST_INSTALL

COPY . .

ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}

# パスワードを環境変数から埋め込んで config.production.json を生成
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > /var/lib/ghost/config.production.json

# knex-migrator の手動初期化（Ghost に任せない）
RUN npx knex-migrator init --mgpath node_modules/ghost

ENTRYPOINT []
CMD ["node", "current/index.js"]
