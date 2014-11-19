class ChangeResultDatatypeInLessons < ActiveRecord::Migration
  def change
    change_column :lessons, :result, :integer, default: 0
  end
end
