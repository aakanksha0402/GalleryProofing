class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  after_action :set_vary_header
  protect_from_forgery with: :exception
  before_filter :current_user, :get_permission

  helper_method :resource_name, :resource, :devise_mapping, :resource_class, :user_details_empty, :current_brand, :options_for_country, :notificaion

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

  def options_for_country
    [
      ['Argentina', 'Argentina'],
      ['Australia', 'Australia'],
      ['Austria','Austria'],
      ['Belgium','Belgium'],
      ['Brazil','Brazil'],
      ['Canada','Canada'],
      ['Chile','Chile'],
      ['Colombia','Colombia'],
      ['Denmark','Denmark'],
      ['Ecuador','Ecuador'],
      ['Finland','Finland'],
      ['France','France'],
      ['Germany','Germany'],
      ['Greece','Greece'],
      ['India','India', selected: true],
      ['Ireland','Ireland'],
      ['Israel','Israel'],
      ['Italy','Italy'],
      ['Mexico','Mexico'],
      ['Netherlands','Netherlands'],
      ['New Zealand','New Zealand'],
      ['Norway','Norway'],
      ['Philippines','Philippines'],
      ['Poland','Poland'],
      ['Singapore','Singapore'],
      ['Slovenia','Slovenia'],
      ['South Africa','South Africa'],
      ['Spain','Spain'],
      ['Sweden','Sweden'],
      ['Switzerland','Switzerland'],
      ['United Arab Emirates','United Arab Emirates'],
      ['United Kingdom','United Kingdom'],
      ['United States','United States']
    ]
  end

  private

  def cart(gallery_visitor)
    puts "in the cart method"
    unless session["cart_id_#{gallery_visitor}"].present?
      @cart = Cart.where("gallery_visitor_id = ? AND is_active = ?", gallery_visitor, true).first
      if @cart.present?
        session["cart_id_#{gallery_visitor}"] = @cart.id
      end
    end
    Cart.find(session["cart_id_#{gallery_visitor}"])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create(gallery_visitor_id: gallery_visitor)
    session["cart_id_#{gallery_visitor}"] = cart.id
    cart
  end

  def get_permission
    return unless session[:user]
    @current_user_permissions = Permission.where(user_id: session[:user].id)
  end

  def current_user
    return unless session[:user_id]
    current_user ||= User.includes(:brands).find(session[:user_id])
    session[:user] = current_user
    if current_user.studio_id.present?
      @current_user = User.includes(:brands).find(current_user.studio_id)
    else
      @current_user = User.includes(:brands).find(session[:user_id])
    end
  end

  def current_brand
    brand = current_user.brands.find_by(user_id: current_user.id, default: true)
  end

  def notificaion
    @notify = Notification.where(brand_id: current_brand.id, is_dismiss: false).last(4).reverse
  end

  def set_vary_header
    if request.xhr?
      response.headers["Vary"] = "accept"
    end
  end
end
