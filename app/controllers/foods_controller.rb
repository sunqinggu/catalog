

class FoodsController < ApplicationController
  def index
    @foods = Food.all

    render("foods_templates/index.html.erb")
  end

  def show
    @food = Food.find(params[:id])
    require 'open-uri'
    @location = JSON.parse(open("https://maps.googleapis.com/maps/api/geocode/json?address=" + @food.store_address).read)['results'][0]['geometry']['location']
    render("foods_templates/show.html.erb")
  end

  def new_form
    render("foods_templates/new_form.html.erb")
  end

  def create_row
    @food = Food.new

    @food.ingredient = params[:ingredient]
    @food.spice = params[:spice]
    @food.measurement = params[:measurement]
    @food.store_address = params[:store_address]
    @food.save
    redirect_to("/foods")
  end

  def edit_form
    @food = Food.find(params[:id])

    render("foods_templates/edit_form.html.erb")
  end

  def update_row
    @food = Food.find(params[:id])

    @food.ingredient = params[:ingredient]
    @food.spice = params[:spice]
    @food.measurement = params[:measurement]
    @food.store_address = params[:store_address]

    @food.save

    redirect_to("/foods/" + @food.id.to_s)
  end

  def destroy_row
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to("/foods")
  end
end
