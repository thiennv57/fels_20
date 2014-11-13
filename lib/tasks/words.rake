namespace :db do
  desc "populate words"
  task words: :environment do
    cat_1 = Category.first
    cat_2 = Category.find 2

    1.upto(100) do |i|
      word = Word.create content: "word #{i}"
      cat_1.words << word
    end

    101.upto(200) do |i|
      word = Word.create content: "word #{i}"
      cat_2.words << word
    end
  end
end