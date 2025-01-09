require "rails_helper"

RSpec.describe Admin::TeachersController, type: :controller do
  let(:admin_teacher) { create(:teacher, :admin) }
  let(:regular_teacher) { create(:teacher) }
  let(:teacher_params) { { first_name: "John", last_name: "Doe", email: "john.doe@example.com", admin: false, password: "password", password_confirmation: "password" } }
  let(:teacher_to_destroy) { create(:teacher) }

  before do
    sign_in admin_teacher
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "shows the list of teachers" do
      create(:teacher, first_name: "Jane", last_name: "Smith")
      get :index
      expect(assigns(:teachers).count).to eq(2)
    end
  end

  describe "GET #new" do
    it "renders the new teacher form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when the teacher is valid" do
      it "creates a new teacher and redirects to the index page" do
        expect {
          post :create, params: { teacher: teacher_params }
        }.to change(Teacher, :count).by(1)
        expect(response).to redirect_to(admin_teachers_path)
        expect(flash[:success]).to eq("Teacher created successfully.")
      end
    end

    context "when the teacher is invalid" do
      it "re-renders the new page with errors" do
        post :create, params: { teacher: { first_name: "", last_name: "", email: "" } }
        expect(response).to render_template(:new)
        expect(assigns(:teacher).errors.any?).to be(true)
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit teacher form" do
      teacher = create(:teacher)
      get :edit, params: { id: teacher.id }
      expect(response).to render_template(:edit)
      expect(assigns(:teacher)).to eq(teacher)
    end
  end

  describe "PATCH #update" do
    let(:teacher) { create(:teacher, first_name: "Old", last_name: "Name") }

    context "when the update is successful" do
      it "updates the teacher and redirects to the index page" do
        patch :update, params: { id: teacher.id, teacher: { first_name: "New", last_name: "Name" } }
        expect(teacher.reload.first_name).to eq("New")
        expect(response).to redirect_to(admin_teachers_path)
        expect(flash[:success]).to eq("Teacher updated successfully.")
      end
    end

    context "when the update is unsuccessful" do
      it "re-renders the edit page with errors" do
        patch :update, params: { id: teacher.id, teacher: { first_name: "", last_name: "", password: "" } }
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to eq("Please enter changes to update Teacher account")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when the teacher tries to delete their own account" do
      it "does not delete the teacher and shows an alert" do
        delete :destroy, params: { id: admin_teacher.id }
        expect(response).to redirect_to(admin_teachers_path)
        expect(flash[:alert]).to eq("You cannot delete your own account.")
      end
    end

    context "when an admin deletes another teacher" do
      it "deletes the teacher and redirects to the index page" do
        delete :destroy, params: { id: teacher_to_destroy.id }
        expect(Teacher.exists?(teacher_to_destroy.id)).to be(false)
        expect(response).to redirect_to(admin_teachers_path)
        expect(flash[:notice]).to eq("Teacher deleted successfully.")
      end
    end
  end
end
