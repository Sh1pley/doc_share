class TeachersController < ApplicationController
  before_action :authenticate_teacher!, only: [ :dashboard ]
  def dashboard
    if teacher_signed_in?
      @teacher = current_teacher
      @documents = current_teacher.documents.order(created_at: :desc)
      @document = Document.new
    end
  end
end
