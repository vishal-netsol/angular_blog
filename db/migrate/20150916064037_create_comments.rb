class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :blog, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :blogs
  end
end
