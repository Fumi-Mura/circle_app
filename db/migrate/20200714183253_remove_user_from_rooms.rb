class RemoveUserFromRooms < ActiveRecord::Migration[5.1]
  def change
    remove_reference :rooms, :user, foreign_key: true
  end
end
