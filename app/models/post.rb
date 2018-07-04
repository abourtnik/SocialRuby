class Post < ApplicationRecord

 validates :content, presence: true, length: { in: 1..100 }

 belongs_to :user , counter_cache: true
 has_many :likes
end