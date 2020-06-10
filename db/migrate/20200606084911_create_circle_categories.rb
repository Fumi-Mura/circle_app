class CreateCircleCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_categories do |t|
      t.integer :circle_id
      t.integer :category_id

      t.timestamps
    end
  end
end
