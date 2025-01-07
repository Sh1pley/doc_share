class DocumentsController < ApplicationController
  before_action :authenticate_teacher!

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to root_path, notice: "Document uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :file, :teacher_id)
  end
end
