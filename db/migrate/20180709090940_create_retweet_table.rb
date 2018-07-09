class CreateRetweetTable < ActiveRecord::Migration[5.2]
  def change
    create_table :retweets do |t|
      t.timestamps
    end
    add_reference :retweets, :user, foreign_key: true
    add_reference :retweets, :post, foreign_key: true
  end
end
