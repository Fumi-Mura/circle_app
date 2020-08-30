
# ワンプレ
![image](https://user-images.githubusercontent.com/63145482/89443568-6b5e7580-d78b-11ea-8965-2cd17e47e9eb.png)<br>

## URL
### **https://www.ones-palce.com**<br>

## 概要
趣味で繋がるコミュニティ作成・参加サービスになります。<br>
投稿にいいね機能をもたせることで活動の発信を促し、個人ではなく集団で育てるSNSとしての狙いもあります。<br>
開発環境と本番環境にDocker、インフラにAWSを利用し、CircleCIを用いて自動テストを構築しています。<br>

## 制作背景
新しい人・物・事との出会いが好きで、そのためのプラットフォームになればと思い制作しました。<br>
１人では挑戦が苦手でも同じ気持ちを持つ人と繋がることで、次の一歩を踏み出すきっかけになればと思います。<br>

## 使用言語
Ruby 2.6.3, Rails 5.1.6<br>
Javascript(Jquery), HTML5, Sass, Bootstrap<br>

## 使用技術
AWS(VPC, EC2, RDS, Route53, ACM, ALB)<br>
Docker, docker-compose<br>
CircleCI(rspec, rubocop自動化)<br>
MySQL<br>
Rspec<br>
Nginx, Unicorn<br>
Git<br>

## ER図
![image](https://user-images.githubusercontent.com/63145482/89771312-1039d380-db3b-11ea-96ac-03ce0633a97f.png)

## サービス構成図
![image](https://user-images.githubusercontent.com/63145482/91665950-3946f600-eb34-11ea-815b-b4c6e0a087d3.png)<br>


## 機能一覧
### ○認証機能(device)<br>
    ・新規登録、ログイン、ログアウト<br>
        name, email, password必須、ログイン時はemailとpasswordのみでログイン可能<br>
    ・ゲストログイン機能<br>
        閲覧用のユーザー<br>
        削除不可<br>
    ・管理者ユーザー機能<br>
        管理用のユーザー<br>
        ゲストユーザー以外のユーザー及び、全てのサークルとブログを編集・削除可能<br>

### ○サークル作成機能<br>
    ・登録、編集、削除<br>
    ・タグ付け<br>
        カテゴリーと活動場所でタグ付け可能<br>

### ◯検索機能(ransack)<br>
    ・サークルに対して検索可能<br>
        サークル名(フリーワード)、タグつけしたカテゴリー又は、活動場所で検索可能<br>

### ○ブログ作成関係<br>
    ・投稿(作成したcircleに紐づく)、編集、削除<br>

### ◯コメント機能<br>
    ・ブログに対して送信可能<br>

### ◯いいね機能<br>
    ・ブログに対していいね可能<br>
        いいね数に応じてランキングを表示<br>

### ◯フォロー機能<br>
    ・フォロー・アンフォロー、フォロー・フォロワー一覧表示機能<br>

### ◯メッセージ機能<br>
    ・action cableを用いたメッセージ<br>
    ・一覧機能<br>
        メッセージの最初の10文字・送信日時を表示可能<br>

### ○その他機能<br>
    ・ページネーション<br>
    ・Ajaxによる非同期処理<br>
    ・レスポンシブ対応<br>
    ・SNSシェア機能<br>
        投稿したブログをfacebook, twitter, lineにシェア可能<br>

### ○テスト<br>
    ・Rspec<br>

### 参考、類似にさせていただいたサービス
「つなげーと」<br>
    **https://tunagate.com**<br>
「サークルブック」<br>
    **https://www.circle-book.com**<br>
「ジモティ」<br>
    **https://jmty.jp**<br>