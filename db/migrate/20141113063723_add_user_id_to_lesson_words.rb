class AddUserIdToLessonWords < ActiveRecord::Migration
  def change
    add_column :lesson_words, :user_id, :integer
  end
end
