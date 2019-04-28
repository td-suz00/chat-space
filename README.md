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


>## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|varchar(255)|null: false|
|email|varchar(255)|null: false, unique: true|

### Association
- has_many :comments
- has_many :groups, through: :members

<br />
<br />

>## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|varchar(255)|null: false|
|image|varchar(255)||
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user

<br />
<br />

>## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|varchar(255)|null: false|

### Association
- has_many :users, through: :members

<br />
<br />

>## membersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user
