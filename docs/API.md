# API

## レスポンスの確認

`GET /api/hello`

## ユーザー

`GET /api/users/search?q=&page=`

ユーザの検索

`GET /api/users/me`

自身のレコードを取得

`POST /api/users`

ユーザーを作成する

```
{
  login_name: '',
  email: '',
  password: '',
  password_confirmation: ''
}
```

`PUT /api/users/:id`

ユーザーの情報を更新する

```
{
  login_name: '',
  display_name: '',
  image: <image_file>
}
```

## セッション

`POST /api/login`
```
{
  email: '',
  passowrd: '',
  password_confirmation: ''
}
```

`DELETE /api/logout`

`GET /api/auth/twitter/callback`

twitter認証

## フォロー

`POST /api/users/:id/follow`

ユーザーをフォローする

`DELETE /api/users/:id/unfollow`

ユーザーのフォローを解除する

`GET /api/users/:id/following`

フォロー中のユーザーを取得

`GET /api/users/:id/followers`

フォロワーのユーザー一覧を取得

## レビュー

`GET /api/stores`

ストア一覧を取得

`GET /api/product_categories`

商品カテゴリ一覧を取得

`GET /api/reviews?store=&category&per_page=&page=`

レビューの一覧を取得

store
- seven
- family
- lawson

`POST /api/reviews`

レビューの投稿

```
{
  product_name: ''(minimum: 4),
  content: ''(maximun: 500),
  picture: <image_file>,
  price: num,
  rating: num(1..10),
  store_id: num,
  product_category_id: num
}
```

`GET /api/reviews/:id`

レビューの詳細を取得

`PUT /api/reviews/:id`

レビューを更新

```
{
  product_name: ''(minimum: 4),
  content: ''(maximun: 500),
  picture: <image_file>,
  price: num,
  rating: num(1..10),
  store_id: num,
  product_category_id: num
}
```

`DELETE /api/reviews/:id`

レビューを削除

## レビューへのリアクション

`POST /api/reviews/:review_id/reactons`

リアクションを投稿

```
{
  reaction_name: ''
}
```

reaction_name

- AWESOME
- YUMMY
- SOSO
- IFFY

`DELETE /api/reviews/:review_id/reactons/:reaction_name`

リアクションを削除

## レビューへのコメント

`POST /api/reviews/:review_id/comments`

コメントを投稿(リプライを含む)

```
{
  comment: '',
  reply: boolean,
  in_reply_to_id: number
}
```

```shell
curl -X POST http://localhost:3000/api/reviews/47/comments \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJ0b2tlbiI6InpfLVlNd3lKS3l1MFZZaVdGck84ZlEifQ.S9FEhj4_TskHCi2r2LACOfBbAKTiw90uH54B6AL3OOs" \
-H "Content-Type: Application/json" -d '{ "comment": "ほげコメント" }'
```


`DELETE /api/comments/:id`

コメントの削除

`PUT /api/comments/:id`

コメントの更新

```
{
  comment: ''
}
```

`GET /api/comments/:id/replies`

コメントに対するリプライ一覧を取得

## コメントへのいいね

`POST /api/comments/:id/likes`

いいねを投稿

`DELETE api/comments/:id/likes`

いいねを削除

## ダイレクトメッセージ

`GET /api/rooms`

自分が所属するroomの一覧(+各roomの最新１件)を取得

`POST /api/rooms`

roomを作成

```
{
  user_ids: [number...]
}
```

`GET /api/rooms/:id`

room内のメッセージを取得

`DELETE /api/rooms/:id`

roomを削除

`DELETE /api/rooms/:id/leave`

roomから退出

`POST /api/rooms/:id/join`

roomへ入室
```
params: { user_ids: [number...] }
```

`POST /api/rooms/:room_id/direct_messages`

ダイレクトメッセージを送信
```
{
  messages: string,
  image: data,
  data_type: image or message
}
```

`DELETE /api/direct_messages/:id`

ダイレクトメッセージを削除

## コミュニティ

`GET /api/communities`

コミュニティ一覧を取得

query params
```
per_page: 1ページに何件表示するか
page: page番号
```

response
```
[
  {},
]
```

`POST /api/communities`

コミュニティの作成
```json
{
  "title": "string",
  "description": "string",
  "symbol_image": "file",
  "permittion_level": "number"
}
```

`GET /api/communities/:id`

コミュニティの詳細を取得

`DELETE /api/communities/:id`

コミュニティの削除

`POST /api/communities/:id/join`

コミュニティへ参加

`DELETE /api/communities/:id/leave`

コミュニティ退会

## コミュニティへの参加申請

`GET: /api/communities/:community_id/join_requests`

コミュニティに対する参加申請一覧を取得

`POST: /api/communities/:community_id/join_requests`

コミュニティに対して参加申請を送る
```json
{
  "message": "string"
}
```

`GET: /api/communities/:community_id/join_requests/:id`

参加申請の詳細を取得

`POST: /api/communities/:community_id/join_requests/:id/accept`

参加申請を許可

`POST: /api/communities/:community_id/join_requests/:id/reject`

参加申請を拒否
