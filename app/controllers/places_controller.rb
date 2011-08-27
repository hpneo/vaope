class PlacesController < ApplicationController
  uses_tiny_mce :options => {:theme => 'advanced',
    :theme_advanced_toolbar_location => 'top',
    :theme_advanced_toolbar_align => 'left',
    :theme_advanced_statusbar_location => 'bottom',
    :theme_advanced_resizing => true,
    :theme_advanced_buttons1 => %w{bold italic underline separator justifyleft justifycenter justifyright indent outdent separator bullist numlist separator link unlink image separator undo redo},
    :theme_advanced_buttons2 => [],
    :theme_advanced_buttons3 => [],
    :theme_advanced_source_editor_width => 580,
    :theme_advanced_resizing_min_width => 580,
    :theme_advanced_resizing_max_width => 580,
    :content_css => '/stylesheets/tiny_mce.css' }, :only => [:new, :edit]
  
  respond_to :html, :json, :kml

  def index
    conditions = {}
    conditions[:category_id] = params[:cat].split(',') if params[:cat]
    conditions[:area_id] = params[:area].split(',') if params[:area]
    conditions[:user_id] = params[:user] if params[:user]
    if params[:latlng]
      @places = Place.near(params[:latlng], 1.5).where(conditions)
    else
      @places = Place.where(conditions)
    end

    respond_with do |format|
      format.json { render :json => @places }
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = Place.new(:user_id => current_user.id)
    get_categories
  end

  def edit
    @place = Place.find(params[:id])
    get_categories
  end

  def create
    @place = Place.create(params[:place])
    areas = Area.near(@place.lat, @place.lng).all
    if areas.count==1
      @place.area = areas.first
      @place.save
    end
    redirect_to place_path(@place)
  end

  def update
    @place = Place.find(params[:id])
    @place.update_attributes(params[:place])
    areas = Area.near(@place.lat, @place.lng).all
    if areas.count==1
      @place.area = areas.first
      @place.save
    end
    redirect_to place_path(@place)
  end

  def destroy
  end
  
  def get_by_area_and_category
    area = Area.find_by_name(params[:area])
    category = Category.find_by_name(params[:category])

    places = Place.where(:area_id => area.id, :category_id => category.id)
  end

  private
    def get_categories
      @categories = {}
      Category.are_parents.map{|category|
        @categories[category.name] = category.children.map{|children| [children.name, children.id]}
      }
    end

end
