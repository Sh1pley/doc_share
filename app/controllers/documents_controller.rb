class DocumentsController < ApplicationController
  before_action :authenticate_teacher!, only: [ :create, :show ]
  before_action :set_document, only: [ :share_document ]

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
  rescue ArgumentError => e
    respond_to do |format|
      format.html do
        flash[:alert] = e.message
        redirect_to root_path
      end
      format.turbo_stream do
        flash.now[:alert] = e.message
        render turbo_stream: turbo_stream.replace("flash_messages", partial: "layouts/flash_messages")
      end
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def share_document
    if @document.nil?
      flash[:alert] = "Sorry, the document you're looking for could not be found."
      respond_to do |format|
        format.html { render "errors/not_found", status: :not_found }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("flash_messages", partial: "layouts/flash_messages")
        end
      end
    else
      render :show
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

  def set_document
    @document = Document.find_by(slug: params[:slug])
  end
end
