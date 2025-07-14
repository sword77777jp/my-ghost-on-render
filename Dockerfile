# see versions at https://hub.docker.com/_/ghost
FROM ghost:5.14.1

# 作業ディレクトリ
WORKDIR /var/lib/ghost

# コンテナに全てコピー
COPY . .

# パスワードを渡してテンプレートから config.production.json を生成
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > config.production.json

# Ghostにデータベース作成をさせないように環境変数で明示的に設定
ENV database__client=mysql
ENV database__connection__host=aws.connect.psdb.cloud
ENV database__connection__user=plpgoc2zy2akywpfo52x
ENV database__connection__password=${DB_PASSWORD}
ENV database__connection__database=ghost-db
ENV database__connection__ssl__rejectUnauthorized=false
ENV database__createDatabase=false

# Ghost起動
CMD ["node", "current/index.js"]
