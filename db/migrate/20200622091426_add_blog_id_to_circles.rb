class AddBlogIdToCircles < ActiveRecord::Migration[5.1]
  def change
    add_column :circles, :blog_id, :integer
  end
end
