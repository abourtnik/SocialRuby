class AddCounterCacheRetweet < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :retweets_count, :integer, default: 0
  end
end
