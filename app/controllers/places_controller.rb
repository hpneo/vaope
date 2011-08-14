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
  respond_to :html, :json

  def index
    conditions = {}
    if params[:latlng]
      if params[:cat]
        conditions[:category_id] = params[:cat].split(',')
      end
      respond_with do |format|
        format.json { render :json => Place.near(params[:latlng]).where(conditions) }
      end
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = Place.new
    @categories = {}
    Category.are_parents.map{|category|
      @categories[category.name] = category.children.map{|children| [children.name, children.id]}
    }
  end

  def edit
  end
  
  def get_by_area_and_category
    area = Area.find_by_name(params[:area])
    category = Category.find_by_name(params[:category])

    places = Place.where(:area_id => area.id, :category_id => category.id)
  end

end
