# ワンプレ
![image](https://user-images.githubusercontent.com/63145482/89443568-6b5e7580-d78b-11ea-8965-2cd17e47e9eb.png)<br>

## URL
### **https://www.ones-palce.com**<br>

## 概要
趣味で繋がるコミュニティ作成・参加サービスになります。<br>
投稿にいいね機能をもたせることで活動の発信を促し、個人ではなく集団で育てるSNSとしての狙いもあります。<br>
開発環境と本番環境にDocker、インフラにAWSを利用しています。<br>

## 制作背景
新しい人・物・事との出会いが好きで、そのためのプラットフォームになればと思い制作しました。<br>
１人では挑戦が苦手でも同じ気持ちを持つ人と繋がることで、次の一歩を踏み出すきっかけになればと思います。<br>

## 使用言語
Ruby 2.6.3, Rails 5.1.6<br>
Javascript(Jquery), HTML5, Sass, Bootstrap<br>

## 使用技術
AWS(VPC, EC2, RDS, Route53, ACM, ALB)<br>
docker, docker-compose<br>
MySQL<br>
Rspec<br>
Nginx, Unicorn<br>
Git<br>

## ER図
![image](https://user-images.githubusercontent.com/63145482/89445989-dbbac600-d78e-11ea-9202-7f3d24f5248a.png)<br>

## サービス構成図
![image](https://user-images.githubusercontent.com/63145482/89441710-87ace300-d788-11ea-8d8a-051349c6385e.png)<br>


## 機能一覧
○ユーザー関係<br>
・新規登録、ログイン、ログアウト、ゲストユーザー、編集<br>
・フォロー、アンフォロー、フォロー、フォロワー一覧表示<br>
・ダイレクトメッセージ、メッセージ一覧表示<br>
○サークル関係<br>
・登録、編集、削除<br>
・タグ付け、検索<br>
○ブログ関係<br>
・投稿(作成したcircleに紐づく)、編集、削除<br>
・コメント、削除<br>
・いいね、いいね数によるランキング<br>
・SNSシェア<br>
○その他機能<br>
・ページネーション<br>
・Ajaxによる非同期処理<br>
・レスポンシブ対応<br>
○テスト<br>
・Rspec<br>

### 参考、類似にさせていただいたサービス
「つなげーと」<br>
**https://tunagate.com**<br>
「サークルブック」<br>
**https://www.circle-book.com**<br>
「ジモティ」<br>
**https://jmty.jp**<br>
