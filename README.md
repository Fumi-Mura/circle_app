# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
* 


□機能
  ○ユーザー関係
    ・新規登録、ログイン/ログアウト
    ・フォロー、アンフォロー(Ajax)
  ○サークル関係
    ・サークル作成、削除、編集
    ・検索機能
  ○ブログ関係
    ・ブログ作成、編集、削除
    ・コメント送信、削除
    ・いいね、いいね外し
  ○DM機能
    ・DM送信(Ajax)
    ・受信メッセージ一覧
  ○アプリ全体
    ・ページネーション機能
    
□追加したい機能
  ・ゲストユーザー機能
  ・ランキング機能
  ・おすすめ機能
  ・返信機能

□問題点
  ・メッセージ送信がエンターキーのみ→Ajaxによる送信ボタンの実装
  ・送信したメッセージの削除機能
  ・検索が選択式の検索のみ→フリーワードによる検索の追加
  ・サークル作成時にラジオボタン式の選択→場所の選択はプルダウン式(セレクトボックス)