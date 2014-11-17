# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin user
User.create username: "PrinceNorin",
            email: "norin@example.com",
            password: "secret",
            password_confirmation: "secret",
            admin: true
# Normal user
User.create username: "norinhor",
            email: "norin.hor@example.com",
            password: "secret",
            password_confirmation: "secret"

# Categories
10.times do |i|
  Category.create name: "category #{i+1}",
          description: "This is the lessons on the basic cateegory #{i+1}"
end

# Generate words
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

# Generate word answers
words = Word.all
words.each do |word|
  4.times do |i|
    answer = WordAnswer.create content: "english #{(word.id-1)*4 + (i+1)}", word_id: word.id
    answer.update_attribute :correct, true if i == 0
  end
end

# # Generate lessons
# category_1 = Category.find 1
# category_2 = Category.find 2
# user = User.first

# lesson_1 = user.lessons.create
# lesson_2 = user.lessons.create

# category_1.lessons << lesson_1
# category_2.lessons << lesson_2

# random_word_id = category_1.word_ids.sample 20
# random_word_id.each do |word_id|
#   lesson_1.lesson_words.create word_id: word_id, user_id: user.id
# end

# random_word_id = category_2.word_ids.sample 20
# random_word_id.each do |word_id|
#   lesson_2.lesson_words.create word_id: word_id, user_id: user.id
# end

# lesson_1 = user.lessons.create
# lesson_2 = user.lessons.create

# category_1.lessons << lesson_1
# category_2.lessons << lesson_2

# words = Word.unique user, category_1
# random_word = words.sample 20
# random_word.each do |word|
#   lesson_1.lesson_words.create word_id: word.id, user_id: user.id
# end

# words = Word.unique user, category_2
# random_word = words.sample 20
# random_word.each do |word|
#   lesson_2.lesson_words.create word_id: word.id, user_id: user.id
# end