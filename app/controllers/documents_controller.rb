class DocumentsController < ApplicationController
  before_action :authenticate_teacher!, only: [ :create, :show ]
  before_action :set_document, only: [ :show, :destroy ]
  before_action :set_share_document, only: [ :share_document ]
  before_action :authorize_teacher!, only: [ :show ]

  def create
    @document = Document.build_from_params(document_params.merge(teacher_id: current_teacher.id))
    if @document.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Document uploaded successfully." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream
      end
    end
  rescue ArgumentError => e
    respond_to do |format|
      format.html do
        set_flash(:alert, e.message, now: true)
        redirect_to root_path
      end
      format.turbo_stream do
        set_flash(:alert, e.message, now: true)
        render turbo_stream: turbo_stream.replace("flash_messages", partial: "layouts/flash_messages")
      end
    end
  end

  def show
  end

  def destroy
    if current_teacher.admin? || @document.teacher == current_teacher
      @document.destroy
      respond_to do |format|
        format.turbo_stream do
          set_flash(:notice, "Document deleted successfully.", now: true)
          render turbo_stream: turbo_stream.remove(@document) +
            turbo_stream.replace("flash_messages", partial: "layouts/flash_messages")
        end
        format.html do
          redirect_to documents_path, notice: "Document deleted successfully."
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          set_flash(:alert, "You do not have permission to delete this document.", now: true)
          render turbo_stream: turbo_stream.replace("flash_messages", partial: "layouts/flash_messages")
        end
        format.html do
          redirect_to root_path, alert: "You do not have permission to delete this document."
        end
      end
    end
  end

  def share_document
    if @document.nil?
      set_flash(:alert, "Sorry, the document you're looking for could not be found.")

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

  def set_share_document
    @document = Document.find_by(slug: params[:slug])
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def authorize_teacher!
    unless current_teacher.admin? || current_teacher == @document.teacher
      set_flash(:alert, "You do not have permission to view this document.")
      redirect_to root_path
    end
  end
end
