class ChangeResultDatatypeInLessons < ActiveRecord::Migration
  def change
    change_column :lessons, :result, :integer
  end
end
