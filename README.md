## ER図
[![Image from Gyazo](https://i.gyazo.com/551f4120aae789e01c911030d756f6eb.png)](https://gyazo.com/551f4120aae789e01c911030d756f6eb)

## Usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|familyname|string|null: false|
|firstname|string|null: false|
|familyname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthday|date|null: false|
|zip_code|string||
|prefecture_id|bigint||
|city|string||
|address_line|string||
|building_name|string||
|phone_number|string|unique: true|
|profile|text||

### Association
- has_many :items
- has_many :addresses
- has_many :assessments
- has_many :sns_credentials, dependent: :destroy


## Addressesテーブル

|Column|Type|Options|
|------|----|-------|
|familyname|string|null: false|
|firstname|string|null: false|
|familyname_kana|string|null: false|
|firstname_kana|string|null: false|
|zip_code|string|null: false|
|prefecture_id|bigint|null: false|
|city|string|null: false|
|address_line|string|null: false|
|building_name|string||
|phone_number|string||
|user_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :user


## Itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|bigint|null: false, foreign_key: true|
|category_id|bigint|null: false, foreign_key: true|
|brand_id|bigint|null: false, foreign_key: true|
|damage|integer|null: false|
|postage_side|integer|null: false|
|delivery_method|integer|null: false|
|prefecture_id|bigint|null: false, foreign_key: true|
|arrival|integer|null: false|
|price|integer|null: false|
|text|text|null: false|
|status|integer|default(0), not null|
|buyer_id|bigint||


### Association
- belongs_to :user
- has_many :images
- belongs_to :category
- belongs_to :brand
- belongs_to :size
- belongs_to :post_area
- has_one :assesment

## Assessmentsテーブル

|Column|Type|Options|
|------|----|-------|
|comment|string|null: false|
|level|integer||
|user_id|bigint|null: false, foreign_key: true|
|item_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## Imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :item


## Categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size_id|bigint||
|ancestry|string|index: true|

### Association
- has_many :items
- has_ancestry


## Sizesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index: true|

### Association
- has_many :items
- belong_to :category


## Brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|unique: true|

### Association
- has_many :items


## Prefecturesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items

## SnsCredentialsテーブル

|Column|Type|Options|
|------|----|-------|
|uid|string|unique: true|
|provider|string||
|user|integer||

### Association
- belongs_to :user, optional: true