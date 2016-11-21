class PropertiesController < ApplicationController
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
    @properties = Property.all
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
    @property = Property.find_by(id: params[:id])
    return render_not_found if @property.blank?
  end

  def edit
    @property = Property.find_by(id: params[:id])
    return render_not_found if @property.blank?
  end

  def update
    @property = Property.find_by(id: params[:id])
    return render_not_found if @property.blank?

    @property.update_attributes(property_params)
    if @property.valid?
      redirect_to admin_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def property_params
    params.require(:property).permit(:active, :status, :neighborhood, :price, :address)
  end
end
