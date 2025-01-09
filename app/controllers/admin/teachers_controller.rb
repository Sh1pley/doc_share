class Admin::TeachersController < ApplicationController
  before_action :authenticate_teacher!
  before_action :authorize_admin!
  before_action :set_teacher, only: [ :edit, :update, :destroy ]

  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      respond_to do |format|
        set_flash(:success, "Teacher created successfully.")
        format.html { redirect_to admin_teachers_path }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if teacher_params.empty?
      set_flash(:alert, "Please enter changes to update Teacher account")
      render :edit
    elsif @teacher.update(teacher_params)
      respond_to do |format|
        set_flash(:success, "Teacher updated successfully.")
        format.html { redirect_to admin_teachers_path }
      end
    else
      set_flash(:alert, @teacher.errors.full_messages)
      render :edit
    end
  end

  def destroy
    if @teacher == current_teacher
      respond_to do |format|
        format.html { redirect_to admin_teachers_path, alert: "You cannot delete your own account." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash_messages")
        end
      end
    elsif @teacher.destroy
      respond_to do |format|
        format.html { redirect_to admin_teachers_path, notice: "Teacher deleted successfully." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(dom_id(@teacher))
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_teachers_path, alert: "Failed to delete the teacher." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash_messages")
        end
      end
    end
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email, :admin, :password, :password_confirmation).tap do |permitted|
      permitted.compact_blank!
    end
  end

  def authorize_admin!
    unless current_teacher.admin?
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end
end
