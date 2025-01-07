class TeachersController < ApplicationController
  before_action :authenticate_teacher!, only: [ :dashboard ]
  def dashboard
    if teacher_signed_in?
      @teacher = current_teacher
      @document = Document.new
    end
  end
end
