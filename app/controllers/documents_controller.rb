class DocumentsController < ApplicationController
  before_action :authenticate_teacher!,
                :set_document, only: [ :show ]

  def create
    @document = Document.build_from_params(document_params.merge(teacher_id: current_teacher.id))
    if @document.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Document uploaded successfully." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream
      end
    end
  end

  def show
    @document
  end

  private

  def document_params
    params.require(:document).permit(:title, :file, :teacher_id)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
