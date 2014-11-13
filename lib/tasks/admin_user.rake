namespace :db do
  desc "populate admin user"
  task admin_user: :environment do
    User.create username: "PrinceNorin",
                email: "norin@example.com",
                password: "secret",
                password_confirmation: "secret",
                admin: true
  end
end