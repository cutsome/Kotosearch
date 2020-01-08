# [Kotosearch](http://kotosearch.com/)

インバウンド（訪日外国人）事業者用マッチングフォーム。体験アクティビティの提供者 × 旅行会社。<br>
2019年7月より独学でプログラミングを学び始め、Kotosearchは11月ごろから制作にとりかかりました。

## バージョン
Ruby　2.6.2<br>
Rails　6.0.2.1<br>
<br>

## 技術・機能
|項目|使用技術|
|:----:|----|
|言語|HTML　/　CSS　/　JavaScript ( jQuery )　/　Ruby ( Ruby on Rails ) |
|インフラ|Amazon EC2 ( Amazon Linux )　+　Nginx　+　Unicorn|
|デプロイ|Capistrano自動デプロイ|
|データベース|MYSQL|
<br>

+ ユーザー登録・削除・編集・管理権限 機能
+ ２種類のユーザーを別モデルで実装 （ Ownerモデル, Agentモデル ）
+ 永続セッション・アカウント有効化・パスワードリセット 機能
+ ハッシュタグ機能 （ Collection check boxes & jQuery ）
+ 検索機能
+ 画像投稿機能 （ ActiveStorage & Amzon S3 & ImageProcessing ）
+ Webpacker使用 （ アセットパイプライン不使用 ）
+ テスト記述
+ レスポンシブ対応
