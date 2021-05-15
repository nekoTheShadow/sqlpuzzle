# 『SQLパズル 第2版』回答集

[ジョー・セルコ(著), ミック(翻訳) 『SQLパズル 第2版: プログラミングが変わる書き方/考え方』](https://www.shoeisha.co.jp/book/detail/9784798114132)に掲載されている75のクイズについて、自分なりの回答を格納したレポジトリです。


- **いうまでもなく、非公式のため、内容はまったくの無保証です。**
- テストデータやDDLについては、以下の2つを参考にしました。
    - 訳者によるサポートページ: https://www.shoeisha.co.jp/book/detail/9784798114132
    - 本書付属データ: https://www.shoeisha.co.jp/book/detail/9784798114132 
- SQLの稼働確認は PostgreSQL / Docker で実施しました。具体的には以下のコマンドで起動させたPostgreSQLを利用しています。

```
docker run --rm -d \
    -p 5432:5432 \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_PASSWORD=passw0rd \
    -e POSTGRES_DB=testdb \
    postgres:13
```

# 自分用のメモ

未回答の問題を確認するone-liner; ただしパズル67については未回答で判定される。

```
seq 75 | xargs printf "%02d.sql\n" | while read line; do [[ ! -e ${line} ]] && echo ${line}; done
```