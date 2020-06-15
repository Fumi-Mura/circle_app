class CreateCircleCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_categories do |t|
      t.references :circle, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
