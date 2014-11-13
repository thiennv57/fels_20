namespace :db do
  desc "populate word answers"
  task word_answers: :environment do
    words = Word.all

    words.each do |word|
      4.times do |i|
        answer = WordAnswer.create content: "english #{(word.id-1)*4 + (i+1)}", word_id: word.id
        answer.update_attribute :correct, true if i == 0
      end
    end
  end
end