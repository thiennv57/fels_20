class ResultsController < ApplicationController
  before_action :user_auth
  
  def index
    @lessons = current_user.lessons
  end
end
