class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    return current_user if current_user
    auth_hash = request.env["omniauth.auth"]
    uid = auth_hash['uid']
    auth = Authorization.find_by_provider_and_uid("github", uid)
    email = auth_hash['info']['email']
    username = auth_hash['info']['nickname']
    name = auth_hash['info']['name']
    if auth
      #We already know about this user who is signing in with the provider: just return the user associated with the Authorization.
      user = auth.user
      #Update possibly changed user data
      user.email = email if email.present?
      user.name = name if name.present?
      user.save
      auth.update_attributes(username: username) unless auth.username == username
    else
      return redirect_to new_user_registration_path, notice: "Sorry! Can't authenticate you via GitHub because your account's email is secret. Please register the traditional way. " if email.blank?
      user = User.find_by_email(email)
      unless user
        user = User.create!(name: name, email: email, password: Devise.friendly_token[0..8])
      end
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