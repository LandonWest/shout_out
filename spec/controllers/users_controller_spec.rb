require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe '#index' do
    before do
      @users = create_list(:user, 3)
    end
    it 'displays a collecion of users' do
      get :index
      expect(response).to be_success
      expect(assigns(:users).count).to eq 3
      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    before do
      @user = create(:user, first_name: 'Brandon', last_name: 'West', mood: 'happy')
    end
    it 'displays a specific user' do
      get :show, id: @user.id
      expect(response).to be_success
      expect(assigns(:user).first_name).to eq 'Brandon'
      expect(assigns(:user).last_name).to eq 'West'
      expect(assigns(:user).mood).to eq 'happy'
      expect(response).to render_template('show')
    end
  end

  describe '#new' do
    it 'sets up a new user instance' do
      get :new
      expect(response).to be_success
      expect(assigns(:user)).to be_new_record
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    context 'when saving a proper record' do
      it 'creates a new user and saves it to the db' do
        expect {
          post :create, user: {first_name: 'Brandon', last_name: 'West', mood: 'happy'}
        }.to change(User, :count).by(1)
      end
    end
    context 'when record fails to save' do
      it 'renders the new template and does not save to the db' do
        post :create, user: { first_name: nil }
        expect(response).to render_template('new')
        expect(User.count).to eq 0
      end
    end
  end

  describe '#edit' do
    before do
      @user = create(:user)
    end
    it 'displays the user I want to edit' do
      get :edit, id: @user.id
      expect(response).to be_success
      expect(assigns(:user).id).to eq @user.id
      expect(response).to render_template('edit')
    end
  end

  describe '#update' do
    before do
      @user = create(:user, first_name: 'Brandon', last_name: 'West', mood: 'pissed')
    end
    context 'when the update was successful' do
      it 'updates the mood from "pissed" to "happy" and redirects to the users index page' do
        put :update, id: @user.id, user: { mood: 'happy' }
        expect(@user.reload.mood).to eq 'happy'
        expect(response).to be_redirect
        expect(response).to redirect_to users_path
      end
    end
    context 'when the user update fails to save' do
      it 'fails to update the mood from "pissed" to "happy" and renders edit template' do
        put :update, id: @user.id, user: { mood: nil }
        expect(@user.reload.mood).to_not be_nil
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    before do
      @user = create(:user)
    end
    it 'removes the user from the database' do
      expect {
        delete :destroy, id: @user.id
      }.to change(User, :count).from(1).to(0)
      expect(response).to be_redirect
      expect(response).to redirect_to users_path
    end
  end

end
