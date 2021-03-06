require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe EmailTemplatesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # EmailTemplate. As you add validations to EmailTemplate, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmailTemplatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all email_templates as @email_templates" do
      email_template = EmailTemplate.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:email_templates)).to eq([email_template])
    end
  end

  describe "GET #show" do
    it "assigns the requested email_template as @email_template" do
      email_template = EmailTemplate.create! valid_attributes
      get :show, {:id => email_template.to_param}, valid_session
      expect(assigns(:email_template)).to eq(email_template)
    end
  end

  describe "GET #new" do
    it "assigns a new email_template as @email_template" do
      get :new, {}, valid_session
      expect(assigns(:email_template)).to be_a_new(EmailTemplate)
    end
  end

  describe "GET #edit" do
    it "assigns the requested email_template as @email_template" do
      email_template = EmailTemplate.create! valid_attributes
      get :edit, {:id => email_template.to_param}, valid_session
      expect(assigns(:email_template)).to eq(email_template)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new EmailTemplate" do
        expect {
          post :create, {:email_template => valid_attributes}, valid_session
        }.to change(EmailTemplate, :count).by(1)
      end

      it "assigns a newly created email_template as @email_template" do
        post :create, {:email_template => valid_attributes}, valid_session
        expect(assigns(:email_template)).to be_a(EmailTemplate)
        expect(assigns(:email_template)).to be_persisted
      end

      it "redirects to the created email_template" do
        post :create, {:email_template => valid_attributes}, valid_session
        expect(response).to redirect_to(EmailTemplate.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved email_template as @email_template" do
        post :create, {:email_template => invalid_attributes}, valid_session
        expect(assigns(:email_template)).to be_a_new(EmailTemplate)
      end

      it "re-renders the 'new' template" do
        post :create, {:email_template => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested email_template" do
        email_template = EmailTemplate.create! valid_attributes
        put :update, {:id => email_template.to_param, :email_template => new_attributes}, valid_session
        email_template.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested email_template as @email_template" do
        email_template = EmailTemplate.create! valid_attributes
        put :update, {:id => email_template.to_param, :email_template => valid_attributes}, valid_session
        expect(assigns(:email_template)).to eq(email_template)
      end

      it "redirects to the email_template" do
        email_template = EmailTemplate.create! valid_attributes
        put :update, {:id => email_template.to_param, :email_template => valid_attributes}, valid_session
        expect(response).to redirect_to(email_template)
      end
    end

    context "with invalid params" do
      it "assigns the email_template as @email_template" do
        email_template = EmailTemplate.create! valid_attributes
        put :update, {:id => email_template.to_param, :email_template => invalid_attributes}, valid_session
        expect(assigns(:email_template)).to eq(email_template)
      end

      it "re-renders the 'edit' template" do
        email_template = EmailTemplate.create! valid_attributes
        put :update, {:id => email_template.to_param, :email_template => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested email_template" do
      email_template = EmailTemplate.create! valid_attributes
      expect {
        delete :destroy, {:id => email_template.to_param}, valid_session
      }.to change(EmailTemplate, :count).by(-1)
    end

    it "redirects to the email_templates list" do
      email_template = EmailTemplate.create! valid_attributes
      delete :destroy, {:id => email_template.to_param}, valid_session
      expect(response).to redirect_to(email_templates_url)
    end
  end

end
