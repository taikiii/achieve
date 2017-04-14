class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :name
      t.text :content
      
      t.timestamps null: false
    end
  end
end
