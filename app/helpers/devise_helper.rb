module DeviseHelper

  def devise_error_messages!
    resource.errors.full_messages.map { |msg| render('shared/alert', text: msg) }.join.html_safe
  end

end