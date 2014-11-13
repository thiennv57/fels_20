namespace :db do
  desc "populate categories"
  task categories: :environment do
    10.times do |i|
      Category.create name: "category #{i+1}"
    end
  end
end