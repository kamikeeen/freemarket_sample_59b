## Userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|familyname|string|null: false|
|firstname|string|null: false|
|familyname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthday|date|null: false|
|address|string|null: false|
|tell|integer||
|profile|text||

### Association
- has_many :items
- has_many :addresses


## Addressテーブル

|Column|Type|Options|
|------|----|-------|
|familyname|string|null: false|
|firstname|string|null: false|
|familyname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthday|date|null: false|
|address|string|null: false|
|tell|integer||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## Itemテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|damage|integer|null: false|
|size_id|references|null: false, foreign_key: true|
|postage|integer|null: false|
|shipping|integer|null: false|
|post-area_id|references|null:, foreign_key: true|
|arrival|integer|null: false|
|price|integer|null: false|
|text|text|null: false|
|status|boolean|null: false|

### Association
- belongs_to :user
- has_many :item-image
- belongs_to :category
- belongs_to :brand
- belongs_to :size
- belongs_to :post-area


## Item-imageテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item


## Categoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items


## Sizeテーブル

|Column|Type|Options|
|------|----|-------|
|size|integer|null: false|

### Association
- has_many :items


## Brandテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :items


## Post-areaテーブル

|Column|Type|Options|
|------|----|-------|
|area|integer|null: false|

### Association
- has_many :items