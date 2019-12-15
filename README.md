# README
## ビデオチャットアプリ
ワーキングホリデー経験者とこれから行きたい人のコミュケーションアプリ

## 機能一覧
ビデオチャット機能
チャットレビュー機能
都市検索機能


* Ruby version
    2.5.1

* Database creation

## user table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|email|string|null:false,unique:true|
|encrypted_password|string|null:false,unique:true|
|profile|string|null:false|
|icon|string|null:false|
|background_image|string||
|area_id|string||
|ticket|integer||
|adviser|boolean|default:false|
|admin|boolean|default:false|

### Association
- belongs_to :area
- has_many :chats
- has_many :chat_reviews
- has_many :blogs
- has_many :schedules
- has_many :messages
- has_many :voices


## chats table
|Column|Type|Options|
|------|----|-------|
|user_peer_id|string||
|start_at|datetime|null: false|
|adviser|references|null: false,index: true, foreign_key:{to_table::users}|
|user|references|null: false,index: true, foreign_key: {to_table: :users|

### Association
-  belongs_to :adviser, class_name: "User"
-  belongs_to :user, class_name: "User"
-  has_many :chat_reviews
-  has_many :messages
-  has_many :voices


## chat_reviews table
|Column|Type|Options|
|------|----|-------|
|score|integer|null: false|
|text|text|null: false|
|chat|references|null: false,index: true, foreign_key:{to_table::users}|
|reviewee|references|null: false,index: true, foreign_key:{to_table::users}|
|user|references|null: false,index: true, foreign_key: {to_table: :users|

### Association
-  belongs_to :user, class_name: "User"
-  belongs_to :reviewee, class_name: "User"
-  belongs_to :chat


## merits table
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|

### Association
-  has_many :areas_merits
-  has_many :areas, through: :areas_merits


## schedules table
|Column|Type|Options|
|------|----|-------|
|availability|boolean|default: false|
|day|integer|null: false|
|start_time|time||
|end_time|time||
|user|references|null: false,index: true, foreign_key: true|

### Association
- belongs_to :user


## areas table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,index: true|
|description|text|null: false|
|image|string||
|limit|string||
|term|string||
|ancestry|string|index: true|

### Association
-  has_many :areas_merits
-  has_many :merits, through: :areas_merits


## areas_merits table
|Column|Type|Options|
|------|----|-------|
|area|references|null: false,index: true, foreign_key: true|
|merit|references|null: false,index: true, foreign_key: true|

### Association
-  has_many :areas
-  has_many :merits


## voices table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|chat|references|null: false,index: true, foreign_key: true|
|user|references|null: false,index: true, foreign_key: true|

### Association
-  belongs_to :chat
-  belongs_to :user


## messages table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|chat|references|null: false,index: true, foreign_key: true|
|user|references|null: false,index: true, foreign_key: true|

### Association
-  belongs_to :chat
-  belongs_to :user



## blogs table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|title|string|null: false|
|user|references|null: false,index: true, foreign_key: true|

### Association
-  belongs_to :user
