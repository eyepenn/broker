class PropertiesController < ApplicationController
  before_action :authenticate_user!, only: [:admin, :new, :create, :edit, :update, :destroy]

  def index
    @properties = Property.order(price: :desc)
  end

  def sales
    @sales = Property.order(price: :desc).where(active: 'yes', status: 'sale')
    @sold = Property.order(price: :desc).where(active: 'yes', status: 'sold')
  end

  def rentals
    @rentals = Property.order(price: :desc).where(active: 'yes', status: 'rent')
  end

  def admin
    @sales = Property.order(price: :desc).where(status: 'sale')
    @sold = Property.order(price: :desc).where(status: 'sold')
    @rentals = Property.order(price: :desc).where(status: 'rent')
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.create(property_params)
    if @property.valid?
      redirect_to admin_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @property = current_property
    return render_not_found if @property.blank?
  end

  def edit
    @property = current_property
    return render_not_found if @property.blank?
  end

  def update
    @property = current_property
    return render_not_found if @property.blank?

    @property.update_attributes(property_params)
    if @property.valid?
      redirect_to admin_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @property = current_property
    return render_not_found if @property.blank?
    @property.destroy
    redirect_to admin_path
  end

  private

  def current_property
    @current_property ||= Property.find_by(id: params[:id])
  end

  def property_params
    params.require(:property).permit(:active, :status, :neighborhood, :price, :address, :proximity, :description, :doorman, :outdoor, :notes, :property_type, :bed, :bath, :maintenance)
  end
end
