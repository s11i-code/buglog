class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    return current_user if current_user
    auth_hash = request.env["omniauth.auth"]
    uid = auth_hash['uid']
    auth = Authorization.find_by_provider_and_uid("github", uid)
    if auth
      #We already know about this user who is signing in with the provider: just return the user associated with the Authorization
      user = auth.user
    else
      email = auth_hash['info']['email']
      user = User.find_by_email(email)
      unless user
        name = auth_hash['info']['name']
        user = User.create!(name: name, email: email, password: Devise.friendly_token[0..8])
      end
      username = auth_hash['info']['nickname']
      auth = user.authorizations.build(provider: "github", uid: uid, username: username)
      user.authorizations << auth
    end
    if user && user.persisted?
      sign_in_and_redirect user, :event => :authentication
    else
      redirect_to :new_user_registration
    end
  end
end