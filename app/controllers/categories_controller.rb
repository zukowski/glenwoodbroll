class CategoriesController < ApplicationController
  load_and_authorize_resource

  def create
    if @category.save
      redirect_to Category, :notice => "Category created."
    else
      render :new
    end
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to Category, :notice => "Category updated."
    else
      render :edit
    end
  end
  
  def destroy
    @category.destroy
    redirect_to Category, :notice => "Category removed."
  end
end
