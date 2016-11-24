require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  describe 'property#index' do
    it 'it should show the index page' do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe 'property#sales' do
    it 'it should show the sales page' do
      get :sales
      expect(response).to have_http_status :success
    end
  end

  describe 'property#rentals' do
    it 'it should show the rentals page' do
      get :rentals
      expect(response).to have_http_status :success
    end
  end

  describe 'property#admin' do
    it 'it should not allow unauthenticated to admin page' do
      get :admin
      expect(response).to redirect_to new_user_session_path
    end

    it 'it should show the admin page' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :admin
      expect(response).to have_http_status :success
    end
  end

  describe 'property#show' do
    it 'it should successfully show the page if the property is found' do
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      get :show, id: property.id
      expect(response).to have_http_status :success
    end

    it 'it should show a 404 error if the property is not found' do
      FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      get :show, id: 'BIGSKY'
      expect(response).to have_http_status :not_found
    end
  end

  describe 'property#new' do
    it 'it should not allow unauthenticated to new page' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'it should show the new page' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status :success
    end
  end

  describe 'property#create' do
    it 'it should not allow unauthenticated to create a property' do
      post :create, property: { active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder' }
      expect(response).to redirect_to new_user_session_path
    end

    it 'it should allow a user to create a new property' do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, property: { active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder' }
      expect(response).to redirect_to admin_path
      property = Property.last

      expect(property.active).to eq('Yes')
    end

    it 'it should deal with vaildation errors' do
      user = FactoryGirl.create(:user)
      sign_in user
      property_count = Property.count
      post :create, property: { active: ' ' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(property_count).to eq 0
    end
  end

  describe 'property#edit' do
    it 'it should not allow unauthenticated to edit page' do
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      get :edit, id: property.id
      expect(response).to redirect_to new_user_session_path
    end

    it 'it should show the edit page' do
      user = FactoryGirl.create(:user)
      sign_in user
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      get :edit, id: property.id
      expect(response).to have_http_status :success
    end

    it 'it should show a 404 error if the property is not found' do
      user = FactoryGirl.create(:user)
      sign_in user
      FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      get :edit, id: 'BIGSKY'
      expect(response).to have_http_status :not_found
    end
  end

  describe 'property#update' do
    it 'it should not allow unauthenticated to update a property' do
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      patch :update, id: property.id, property: { active: 'No' }
      expect(response).to redirect_to new_user_session_path
    end

    it 'it should allow a user to update a property' do
      user = FactoryGirl.create(:user)
      sign_in user
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      patch :update, id: property.id, property: { active: 'No' }
      expect(response).to redirect_to admin_path
      property.reload
      expect(property.active).to eq 'No'
    end

    it 'it should return a 404 error if we cannot find a property with the id' do
      user = FactoryGirl.create(:user)
      sign_in user
      FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      patch :update, id: 'BIGCAT', property: { active: 'No' }
      expect(response).to have_http_status :not_found
    end

    it 'it should render the edit form with an http status of unprocessable entity' do
      user = FactoryGirl.create(:user)
      sign_in user
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      patch :update, id: property.id, property: { active: '' }
      expect(response).to have_http_status :unprocessable_entity
      property.reload
      expect(property.active).to eq 'Yes'
    end
  end

  describe 'property#delete' do
    it 'it should not allow unauthenticated to delete a property' do
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      delete :destroy, id: property.id
      expect(response).to redirect_to new_user_session_path
    end

    it 'it should allow a user to destroy a property' do
      user = FactoryGirl.create(:user)
      sign_in user
      property = FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      delete :destroy, id: property.id
      expect(response).to redirect_to admin_path
      property = Property.find_by(id: property.id)
      expect(property).to eq nil
    end

    it 'it should return a 404 error if we cannot find a property with the id' do
      user = FactoryGirl.create(:user)
      sign_in user
      FactoryGirl.create(:property, active: 'Yes', status: 'Sale', neighborhood: 'Park Slope', price: '300000', address: 'Grand Army Plaza', proximity: 'Subway', description: 'Warm', doorman: 'No', outdoor: 'No', notes: 'Roomy', property_type: 'Condo', bed: '1', bath: '1', maintenance: '500', images: '1', images_folder: 'folder')

      delete :destroy, id: 'BIGTRUCK'
      expect(response).to have_http_status :not_found
    end
  end
end
