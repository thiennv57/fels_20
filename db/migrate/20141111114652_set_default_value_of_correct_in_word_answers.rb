class SetDefaultValueOfCorrectInWordAnswers < ActiveRecord::Migration
  def change
    change_column :word_answers, :correct, :boolean, default: false
    WordAnswer.all.each do |ans|
      ans.update_attribute :correct, false
    end
  end
end
