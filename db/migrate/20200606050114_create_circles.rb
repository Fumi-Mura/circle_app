class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles do |t|
      t.integer :user_id
      t.string :name
      t.text :content
      t.string :place
      t.string :image_id

      t.timestamps
    end
  end
end
