# DB

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|unique: true|
|profile|string|

### Association
- has_many :items
- has_one :adress
- has_one :credit

## adress tables
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kane|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building_name|string|null: false|
|tel|integer|null: false|

## Association
- belongs_to :user

## credit table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|card_number|integer|null: false|
|expiration_month|integer|null: false|
|expiration_year|integer|null: false|
|security_code|integer|null: false|

## Associaion
- belongs_to :user

## items table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false, index :true|
|condition|integer|null :false|
|brand_id|references|foreign_key: true, null :false|
|user_id|references|foreign_key: true, null :false|
|category_subchild_id|references|foreign_key: true, null :false|
|price|integer|null :false|
|description|string|null :false|
|status|string|null :false|

### Association
- belongs_to :brand
- belongs_to :user
- belongs_to :category_subchild
- has_many :images

## brands table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|

### Association
- has_many :items

## caterories table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|

### Association
- has_many :category_childrens

## category_children table


|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
|category_id|references|foreign_key: true, null :false|

### Association
- has_many :category_subchildrens
- belongs_to :category

## category_subchildren table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
|category_child_id|references|foreign_key: true, null :false|

### Association
- belongs_to :category_child
- has_many :items

## images table

|Column|Type|Options|
|------|----|-------|
|image|string|null :false|
|item_id|references|foreign_key: true, null :false|

### Association

- belongs_to :item
