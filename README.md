# EmoBridge

## サービス概要
EmoBridge（エモブリッジ）は夫婦やカップルがお互いの感情を理解し、円満なコミュニケーションを図るためのサービスです。

## 想定されるユーザー層
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

## 画面遷移図
https://www.figma.com/file/AkZOpf1wkbdog1Dg8NHUH8/%E8%AA%B2%E9%A1%8C?type=design&node-id=0%3A1&mode=design&t=pEkxj7krkbQMIfUS-1

1. **ログイン画面**：ユーザーがアプリにログインします。フォームは「メールアドレス」「パスワード」。ボタンは「ログイン（４へ）」、「サインアップ（２へ）」。リンク「パスワードをお忘れた（３へ）」。ヘッダー「ログイン（１へ）」「サインアップ（２へ）」
2. **サインアップ画面**（１→２）：入力フォーム画面「名前」「メールアドレス」「パスワード」「パスワード確認」、「私は利用規約（４へ）とプライバシーポリシー（５へ）に同意します。」
3. **仮パスワード送信画面**（１→３）：フォームは「メールアドレス」。ボタン「送信する」。
4. **利用規約画面**（２→４）：利用規約を表示。
5. **プライバシーポリシー**（２→５）：プライバシーポリシーを表示。
6. **ログイン後ホーム画面**（１→６）：ログイン後、ユーザーはホーム画面に遷移する。ここでは、トップ画像と中央に紙飛行機のアイコンを表示。このアイコンをクリックすると感情入力画面へ（１１へ）。
7. **ログイン後全ページ共通**：ヘッダー左側「ハンバーガーメニュー（「招待（８へ）」「設定（９へ）」「ヘルプ（１０へ）」「ログアウト（１へ）」）」と右側「鈴（通知）」とする。フッターにボタンを「ホーム（６へ）」「マイページ（１１へ）」、「パートナーの記録（１３へ）」「自身の記録（１４へ）」設ける。
8. **招待**（７→８）：入力フォーム「ID入力」（設定画面にあるIDを入力すると相手へ招待できる。）ボタン「送信」。共有者リスト（確認と削除ができる）
9. **設定**（８→９）：プロフィールの設定（編集できる）。ボタン「保存する」。
10. **ヘルプ**（７→８）：ヘルプを表示。
11. **マイページ**：ページ上部に自身のプロフィール画像の横に名前が表示される。ボタン「変更（９へ）」。中央にカテゴリーの設定、相手に伝えたいことのテンプレート作成、編集操作が可能。ボタン「保存」
12. **感情入力画面**（６→１２）：ユーザーが感情を選択、感情の詳細を入力する画面に遷移します。ここでは、ユーザーの状態を選択して、その後、ユーザーが感情の原因をカテゴリーから選択し、5段階評価できます。その後、伝えたいことを選択する。その他を選択すると自由記入欄が表示されて入力できる。ボタン「保存（１３へ）」
13. **ポップアップ画面**（１２→１３）：相手のLINEへ送信しますか。ボタン「送信する（６へ）」「送信しない（６へ）」
14. **パートナーの記録**（７→１４）：共有（EmoBridge）した相手の記録がリスト表示されます。
15. **自身の記録**（７→１５）：自身の記録がリスト表示されます。

## ER図
[![Image from Gyazo](https://i.gyazo.com/12bcc494376bd622c895c1a9ec705790.png)](https://gyazo.com/12bcc494376bd622c895c1a9ec705790)

1. **Usersテーブル**
ユーザーの情報の管理する（ログイン機能：sorceryを想定）
- id (integer): ユーザーID。
- name (string): ユーザー名。
- email (string): ユーザーのメールアドレス。
- crypted_password (string): ユーザーのパスワード。
- salt (string): ユーザーのパスワード。
- avatar (string): ユーザーのアイコン画像。
2. **Emotionsテーブル**
ユーザーの感情記録を管理する
- id (integer): 感情記録のID。
- user_id (integer): この感情記録を作成したユーザーのID。
- feeling (string): ユーザーが選択した感情を表す顔文字。
- feeling_score (integer): 顔文字にリンクした数値。追加機能の感情分析で使用予定。
3. **Categoriesテーブル**
感情評価のカテゴリー一覧を管理する
- id (integer): カテゴリーのID。
- name (string): カテゴリーの名前。
4. **UserCategoriesテーブル**
ユーザーが使用する感情評価カテゴリー一覧を管理
- id (integer): ユーザーカテゴリーのID。
- user_id (integer): このカテゴリーを設定したユーザーのID。
- category_id (integer): ユーザーが設定したカテゴリーのID。
5. **EmotionCategoriesテーブル**
感情記録と感情評価カテゴリーの関係を管理する
- id (integer): 感情カテゴリーのID。
- emotion_id (integer): このカテゴリー評価が関連する感情記録のID。
- user_category_id (integer): 評価されたユーザーカテゴリーのID。
- rating (integer): ユーザーが選択したカテゴリーの評価（1から5まで）。
6. **EmotionMessagesテーブル**
感情記録と伝えたいことの関係を管理する
- id (integer): メッセージのID。
- user_id (integer): このメッセージを設定したユーザーのID。
- emotion_id (integer): このメッセージが関連する感情記録のID。
- user_template_id (integer): ユーザー指定するメッセージテンプレート。
- message (text): ユーザーが入力するメッセージ。
7. **UserTemplatesテーブル**
ユーザーがセットしているテンプレートを管理する
- id (integer): ユーザーメッセージのID。
- user_id (integer): このメッセージを設定したユーザーのID。
- message_template_id (integer): ユーザーが設定したメッセージテンプレートのID。
8. **MessageTemplatesテーブル**
メッセージのテンプレートを管理する
- id (integer): メッセージテンプレートのID。
- message (text): テンプレートメッセージ。
9. **EmotionPartnersテーブル**
感情記録を共有したパートナーとの関係を管理する
- id (integer): パートナー関係のID。
- user_id (integer): パートナー関係を設定したユーザーのID。
- partner_id (integer): ユーザーがパートナーとして設定したユーザーのID。
10. **Invitationsテーブル**
ユーザーが共有したいパートナーを招待する際の状態を管理する
- id (integer): 招待のID。
- sender_id (integer): 招待を送ったユーザーのID。
- receiver_id (integer): 招待を受け取ったユーザーのID。
- status (integer): 招待の状態。
11. **Notificationsテーブル**
感情記録の通知を誰が受け取り、誰がそれを送ったか、通知状態を管理する
- id (integer): 通知のID。
- user_id (integer): 通知を受け取るユーザーのID。
- partner_id (integer): 通知を送るパートナーのID。
- emotion_id (integer): 通知が関連する感情記録のID。
- status (integer): 通知の状態。
12. **Likesテーブル（追加機能予定）**
感情記録に良いねをした際に、送ったユーザーと受けたユーザーを管理する
- id (integer): いいねのID。
- emotion_id (integer):いいねされた感情記録のID。
- sender_id (integer): いいねを送ったユーザーのID。
- receiver_id (integer): いいねを受け取ったユーザーのID。
