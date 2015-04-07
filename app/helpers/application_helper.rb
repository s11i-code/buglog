module ApplicationHelper

  def github_sign_in_button
    link_to user_omniauth_authorize_path(provider: :github), class: ['btn btn-block btn-lg btn-social btn-github'] do
      content_tag(:i, '', class: 'fa fa-github') + 'Sign in with GitHub'
    end
  end
end
