FROM ghost:5.14.1

WORKDIR /var/lib/ghost

# 必要ファイルコピー
COPY . .

# 環境変数でパスワードを受け取り、config.production.jsonを生成
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}

RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > config.production.json
