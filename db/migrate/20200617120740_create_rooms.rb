class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true, type: :bigint
      t.string :name

      t.timestamps
    end
  end
end
