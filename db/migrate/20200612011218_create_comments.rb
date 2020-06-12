class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :blog, foreign_key: true
      t.string :name, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end