# ワンプレ
![image](https://user-images.githubusercontent.com/63145482/89443568-6b5e7580-d78b-11ea-8965-2cd17e47e9eb.png)

##URL
### **https://www.ones-palce.com**

##【概要】
趣味で繋がるコミュニティ作成・参加サービスになります。
投稿にいいね機能をもたせることで活動の発信を促し、個人ではなく集団で育てるSNSとしての狙いもあります。
開発環境と本番環境にDocker、インフラにAWSを利用しています。

##【制作背景】
新しい人・物・事との出会いが好きで、そのためのプラットフォームになればと思い制作しました。
１人では挑戦が苦手でも同じ気持ちを持つ人と繋がることで、次の一歩を踏み出すきっかけになればと思います。

##【使用言語】
Ruby 2.6.3, Rails 5.1.6
Javascript(Jquery), HTML5, Sass, Bootstrap

##【使用技術】
AWS(VPC, EC2, RDS, Route53, ACM, ALB)
docker, docker-compose
MySQL
Rspec
Nginx, Unicorn
Git

##【ER図】
![image](https://user-images.githubusercontent.com/63145482/89412618-5b7e6b80-d762-11ea-81b8-cfa41ff88740.png)

##【サービス構成図】
![image](https://user-images.githubusercontent.com/63145482/89441710-87ace300-d788-11ea-8d8a-051349c6385e.png)


##【機能一覧】
●ユーザー関係
・新規登録、ログイン、ログアウト、ゲストユーザー、編集
・フォロー、アンフォロー、フォロー、フォロワー一覧表示
・ダイレクトメッセージ、メッセージ一覧表示
●サークル関係
・登録、編集、削除
・タグ付け、検索
●ブログ関係
・投稿(作成したcircleに紐づく)、編集、削除
・コメント、削除
・いいね、いいね数によるランキング
・SNSシェア
●その他機能
・ページネーション
・Ajaxによる非同期処理
・レスポンシブ対応
●テスト
・Rspec

###【参考、類似にさせていただいたサービス】
「つなげーと」
**https://tunagate.com**
「サークルブック」
**https://www.circle-book.com**
「ジモティ」
**https://jmty.jp**
