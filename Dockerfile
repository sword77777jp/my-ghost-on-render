# Ghost公式の安定バージョンを使用
FROM ghost:5.14.1

# 作業ディレクトリをGhostのデフォルトに設定
WORKDIR /var/lib/ghost

# プロジェクトの全ファイルをコンテナにコピー
COPY . .

# パスワードをビルド時に受け取り、環境変数として定義
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}

# config.template.json の {{PASSWORD}} を置換して config.production.json を生成
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > config.production.json

# データベース再作成を防ぐための環境変数（Ghost内部で参照される）
ENV database__createDatabase=false

# Ghost起動（ENTRYPOINTはデフォルトを使用）
CMD ["node", "current/index.js"]
