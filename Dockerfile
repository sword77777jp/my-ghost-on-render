FROM ghost:5.14.1

WORKDIR /var/lib/ghost

COPY . .

# 環境変数でパスワードを差し替え
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}
RUN sed "s|{{PASSWORD}}|${DB_PASSWORD}|g" config.template.json > config.production.json

# Ghost本体にはCREATE DATABASEさせない（環境変数も使って二重に抑制）
ENV database__createDatabase=false

# Ghost起動（Renderが勝手に node current/index.js を呼び出すのでCMD不要）
