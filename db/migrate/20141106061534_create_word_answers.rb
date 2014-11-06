class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.integer :word_id
      t.string :content
      t.boolean :correct

      t.timestamps
    end
  end
end
