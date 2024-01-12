# EmoBridge

## サービス概要
EmoBridge（エモブリッジ）は夫婦やカップルがお互いの感情を理解し、円満なコミュニケーションを図るためのサービスです。

##　想定されるユーザー層
夫婦、カップル

## サービスコンセプト
夫婦やカップルは時として、お互いの感情が分からないために、上手くコミュニケーションがとれずに
相手の機嫌を損ねてしまい喧嘩に発展することがあります。
これは自身の感情を客観的に分析できずに、相手に十分に伝わっていないことに原因があると思います。
また、一緒に居ない時間に起きた出来事を共有しないままにすることで、慢性的なコミュニケーション不足になります。
そのため、EmoBridge（エモブリッジ）では、夫婦やカップルが自身の「エモーション（感情）」を
相手に「ブリッジ（橋）」でつなげて共有することを目的にしてます。
EmoBridgeでは、アプリのステータス画面から自身の感情を顔文字から選択し、「嬉しい」「疲れた」「体調が悪い」などの感情を表現します。
また、その原因を客観的にカテゴリー（「仕事」「趣味」「育児」「体調」など、任意で編集可能）から、５段階評価します。
その後、共有先の相手に伝えたいことをテンプレート（「話を聞いて欲しい」「独り時間が欲しい」など）から選択あるいは、
自由入力することができます。
最後に、共有先に上記の内容を送信することができ、相手に共有することが可能です。
あるいは、送信せずに自身の感情を日記のように見返すことを目的に記録だけもできます。
なお、この記録はアプリを通してお互いに共有されるので、会話のきっかけになります。

具体的には下記のようなケースを想定しています。

ユーザーが仕事で疲れていて独り時間が欲しいとき：
帰宅前にアプリを開き、自身のステータス画面で感情「疲れた」顔文字を選択します。
その後、カテゴリーから原因である「仕事」低評価し、相手に伝えたいこと「独り時間が欲しい」を選択します。
このメッセージがパートナーにLINE通知として送信します。
パートナーは通知を確認し、それに対してLINEで既読、スタンプ、メッセージなどのアクションを行います。
これにより、パートナーはユーザーの状況を理解し、必要以上に話しかけないなど適切な対応ができます。

ユーザーが仕事で上手くいき、趣味で嬉しいことがあったとき：
休憩時にアプリを開き、自身のステータス画面で感情「嬉しい」顔文字を選択します。
その後、カテゴリーから理由である「仕事」「趣味」は高評価し、相手に伝えたいこと「話を聞いて欲しい」を選択します。
このメッセージがパートナーにLINE通知として送信します。
パートナーは通知を確認し、それに対してLINEで既読、スタンプ、メッセージなどのアクションを行います。
これにより、パートナーはユーザーの状況を理解し、早めに帰宅してゆっくり話を聞いて褒めてあげよう、ちょっと言いにくい
相談を今日しても大丈夫かななど、適切な対応ができます。

ユーザーが日々の記録として趣味で嬉しいことがあったことを記録したいとき：
寝る前にアプリを開き、自身のステータス画面で感情「嬉しい」顔文字を選択します。
その後、カテゴリーから理由である「趣味」は高評価し、自由記入で「ライブチケットをゲットできた」を記入します。
この内容は送信せずに記録だけとします。
後日、パートナーがアプリを確認すると、相手に嬉しいことがあったことが確認でき、会ったときの会話のネタになります。

これにより、お互いの感情を客観視でき、共有できることで、悪いときにはパートナーを思いやる対応ができ、また良いときは、
会話のきっかけにもなり、より円満な関係を図れると考えます。

## サービスの差別化ポイント・推しポイント
### 差別化ポイント
* 感情の可視化：ユーザーが自身の感情を顔文字から選択することで、直感的に感情をパートナーと共有することができます。
* 感情の原因を特定：感情の原因をカテゴリーから選択し、それを5段階評価することで具体的な原因を特定し、それをパートナーと共有することができます。
* 伝えたいことが明確化：ユーザーは伝えたいことをテンプレートから選択、あるいは自由に入力することができるため、ユーザーは自身の感情に対する具体的な要望や期待を明確に伝えることができます。（テンプレートには、普段言いにくいことや相手に配慮した言葉を用意します）

### 推しポイント
* 円満なコミュニケーションの促進：ユーザーが自身の感情をパートナーと共有することで、お互いの理解が深まり、よりコミュニケーションを図ることができます。また、記録を共有することで会話のネタが増え、コミュニケーション不足からも解消されます。
* 感情の記録と振り返り：ユーザーは感情を記録し、日記のように振り返ることができることで、自己理解を深めることできます。

## 実装を予定している機能
### MVP
* 会員登録
* ログイン
* 自身の感情選択（感情がわかる顔文字等の絵を選択）
* 感情の詳細入力（使用者が作成したカテゴリー分けされた情報 例：「仕事」「家事」「子育て」「趣味」について５段階評価する）
* 伝えたいことを入力（テンプレート「話を聞いて」などを選択、あるいは自由記入）
* 共有先への送信
* 入力内容の履歴
* パートナーからの受信履歴

### その後の機能
* 感情分析、アドバイス機能
* 共有相手との通知設定（選択すると自動通知する等）
* 共有相手が適切な対応してくれた数をカウントして称号を付与する

### 機能
下記の技術の使用予定
* Ruby
* Ruby on Rails（ログイン、フォーム画面等）
* postgresqlまたはMysql（データベース）
* JavaScript（パートナーに情報を送信するかどうか確認）
* postgresqlまたはMysql（データベース）
* LINE Messaging API（パートナーに情報をLINE送信）
* ChatGPT API（その後の機能 感情分析、アドバイス）
