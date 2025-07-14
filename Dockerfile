FROM ghost:5.14.1

WORKDIR $GHOST_INSTALL

COPY . .

ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}

# パスワードを環境変数から埋め込んで config.production.json を生成
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > /var/lib/ghost/config.production.json

# 🔥 ここで root 権限に切り替える（Ghostイメージは node ユーザーがデフォルト）
USER root

# knex-migrator をグローバルにインストール（パーミッション問題回避）
RUN npm install -g knex-migrator

# マイグレーション初期化（Ghost DBが空の場合のみ）
RUN knex-migrator init --mgpath node_modules/ghost || true

# 👇 必ず元の node ユーザーに戻す（セキュリティ上重要）
USER node

ENTRYPOINT []
CMD ["node", "current/index.js"]
