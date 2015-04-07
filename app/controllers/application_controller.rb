class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :set_csrf_cookie_for_ng

  around_filter :catch_exceptions

  protected

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def mail_exception(exception, params)
    ErrorMailer.shout_exception(exception, params, current_user, request).deliver
  end

  def catch_exceptions
    yield
  rescue Exception => exception
    if Rails.env.in?(['test', 'development'])
      raise exception
    else
      [:password, :password_confirmation].each { |key| params[:user].try(:delete, key) }
      ErrorMailer.shout_exception(exception, params, current_user, request).deliver
      render(:file => "#{Rails.root}/public/500", :layout => false, :status => 500, :formats => [:html])
    end
  end

  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
