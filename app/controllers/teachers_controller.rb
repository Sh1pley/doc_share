class TeachersController < ApplicationController
  def dashboard
    if teacher_signed_in?
      @teacher = current_teacher
    end
  end
end
