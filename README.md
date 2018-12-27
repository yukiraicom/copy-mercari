# DB

## users table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|profile|string|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kane|string|null: false|
|last_name_kane|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building_name|string|null: false|
|tel|integer|null: false|
|card_number|integer|null: false|
|expiration_month|integer|null: false|
|expiration_year|integer|null: false|
|security_coder|integer|null: false|
|uid|integer|null: false|
|provider|string|null: false|

### Association
- has_many :orders, class_name: 'Order',foreign_key: 'buyer_id'
- has_many :reviewing, class_name: 'Valuation', foreign_key: 'reviewing_id'
- has_many :reviewed, class_name: 'Valuation', foreign_key: 'reviewed_id'
- has_many :comments
- has_many :goods
- has_many :items, through: :goods
- has_many :todo_lists

## statuses table

|Column|Type|Options|
|------|----|-------|
|status|string|null :false|

### Association
-has_many :orders

## orders table

|Column|Type|Options|
|------|----|-------|
|status_id|references|fareign_key: true, null :false|
|item_id|references|fareign_key: true, null :false|
|buyer_id|integer|

### Association
- belongs_to :status

## valuations table

|Column|Type|Options|
|------|----|-------|
|reviewing_id|references|fareign_key: true, null: false|
|reviewed_id||references|fareign_key: true, null: false|
|rate|integer|null: false|
|comment|string|null: false|

### Association
なし

## comments table

|Column|Type|Options|
|------|----|-------|
|item_id|references|fareign_key: true, null :false|
|user_id|references|fareign_key: true, null :false|
|text|string|null :false|

### Association
- belongs_to :user

## goods table

|Column|Type|Options|
|------|----|-------|
|user_id|references|fareign_key: true, null :false|
|item_id|references|fareign_key: true, null :false|

### Association
- belongs_to :user
- belongs_to :item

## todos table

|Column|Type|Options|
|------|----|-------|
|status|string|null :false|

### Association

なし

## todo_lists
|Column|Type|Options|
|------|----|-------|
|user_id|references|fareign_key: true, null :false|
|todo_id|references|fareign_key: true, null :false|

### Association
- belongs_to :todo

## items table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false, index :true|
|condition_id|references|fareign_key: true, null :false|
|brand_id|references|fareign_key: true, null :false|
|user_id|references|fareign_key: true, null :false|
|category_subchild_id|references|fareign_key: true, null :false|
|shipping_id|references|fareign_key: true, null :false|
|order_id|references|fareign_key: true, null :false|
|price|integer|null :false|
|description|string|null :false|

### Association
- belongs_to :condition
- belongs_to :brand
- belongs_to :user
- belongs_to :category_subchild
- belongs_to :shipping
- belongs_to :order
- has_many :images
- has_many :comments
- has_many :goods
- has_many :users, through: :goods

## conditions table

|Column|Type|Options|
|------|----|-------|
|condition|string|null :false|

### Association
なし

## brands table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|

### Association
- has_many :item

## caterories table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|

### Association
-has_many :category_children

## category_children table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
|category_id|references|fareign_key: true, null :false|

### Association
- has_many :category_subchildren
- belongs_to :category

## category_subchildren table

|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
|category_child_id|references|fareign_key: true, null :false|

### Association
- belongs_to :category_child
- has_many :items

## fees table
|Column|Type|Options|
|------|----|-------|
|fee|string|null :false|

### Association

なし

## methods table
|Column|Type|Options|
|------|----|-------|
|method|string|null :false|

### Association

なし

## prefectures table
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null :false|

### Association

なし

## shipping_day table
|Column|Type|Options|
|------|----|-------|
|shipping_day|string|null :false|

### Association

なし

## shippings table

|Column|Type|Options|
|------|----|-------|
|fee_id|references|fareign_key: true, null :false|
|method_id|references|fareign_key: true, null :false|
|prefecture_id|references|fareign_key: true, null :false|
|shipping_day_id|references|fareign_key: true, null :false|

### Association
- belongs_to :fee
- belongs_to :method
- belongs_to :prefecture
- belongs_to :shipping_day

## images table

|Column|Type|Options|
|------|----|-------|
|image|string|null :false|
|item_id|references|fareign_key: true, null :false|

### Association

なし
