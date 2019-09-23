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
|region|string||
|city|string||
|address|string||
|building_name|string||
|phone_number|integer|unique: true|
|profile|text||

### Association
- has_many :items
- has_many :addresses
- has_many :assessments


## Addressesテーブル

|Column|Type|Options|
|------|----|-------|
|familyname|string|null: false|
|firstname|string|null: false|
|familyname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthday|date|null: false|
|zip_code|string|null: false|
|region|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|integer||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## Itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|damage|integer|null: false|
|size_id|references|null: false, foreign_key: true|
|postage|integer|null: false|
|shipping|integer|null: false|
|post-area_id|references|null: false, foreign_key: true|
|arrival|integer|null: false|
|price|integer|null: false|
|text|text|null: false|
|status|boolean|null: false|
|buyer_id|integer||


### Association
- belongs_to :user
- has_many :item-images
- belongs_to :category
- belongs_to :brand
- belongs_to :size
- belongs_to :post-area
- has_one :assesment

## Assessmentsテーブル

|Column|Type|Options|
|------|----|-------|
|comment|string|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## Item-imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item


## Categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items


## Sizesテーブル

|Column|Type|Options|
|------|----|-------|
|size|integer|null: false|

### Association
- has_many :items


## Brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|unique: true|

### Association
- has_many :items


## Post-areasテーブル

|Column|Type|Options|
|------|----|-------|
|area|integer|null: false|

### Association
- has_many :items