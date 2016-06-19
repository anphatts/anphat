class RemoveTypeFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :type
  end
end
