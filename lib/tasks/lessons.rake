namespace :db do
  desc "populate lessons"
  task lessons: :environment do
    category_1 = Category.find 1
    category_2 = Category.find 2
    user = User.first

    lesson_1 = user.lessons.create
    lesson_2 = user.lessons.create

    category_1.lessons << lesson_1
    category_2.lessons << lesson_2

    random_word_id = category_1.word_ids.sample 20
    random_word_id.each do |word_id|
      lesson_1.lesson_words.create word_id: word_id, user_id: user.id
    end

    random_word_id = category_2.word_ids.sample 20
    random_word_id.each do |word_id|
      lesson_2.lesson_words.create word_id: word_id, user_id: user.id
    end

    lesson_1 = user.lessons.create
    lesson_2 = user.lessons.create

    category_1.lessons << lesson_1
    category_2.lessons << lesson_2

    lesson_word_ids = "SELECT word_id FROM lesson_words WHERE lesson_id = :lesson_id"
    words = Word.where("id NOT IN (#{lesson_word_ids}) 
                AND category_id = :category_id",
                category_id: category_1.id,
                lesson_id: lesson_1.id)
    random_word = words.sample 20
    random_word.each do |word|
      lesson_1.lesson_words.create word_id: word.id, user_id: user.id
    end

    lesson_word_ids = "SELECT word_id FROM lesson_words WHERE lesson_id = :lesson_id"
    words = Word.where("id NOT IN (#{lesson_word_ids}) 
                AND category_id = :category_id",
                category_id: category_2.id,
                lesson_id: lesson_2.id)
    random_word = words.sample 20
    random_word.each do |word|
      lesson_2.lesson_words.create word_id: word.id, user_id: user.id
    end
  end
end