class AddTimestampsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :created_at, :datetime, {null: false}
    add_column :articles, :updated_at, :datetime, {null: false}
  end
end
