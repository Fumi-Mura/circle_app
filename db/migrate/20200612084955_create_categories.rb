class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :kind
      t.string :place

      t.timestamps
    end
  end
end
