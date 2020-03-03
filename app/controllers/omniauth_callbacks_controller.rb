class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :check_guisso_cookie

  def instedd
    generic do |auth|
      {
        email: auth.info['email']
        # name: auth.info['name'],
      }
    end
  end

  def failure
    render plain: params.inspect
  end

  def generic
    auth = env['omniauth.auth']

    if identity = Identity.find_by_provider_and_token(auth['provider'], auth['uid'])
      user = identity.user
    else
      attributes = yield auth

      user = User.find_by_email(attributes[:email])
      unless user
        password = Devise.friendly_token
        user = User.new(attributes.merge(password: password, password_confirmation: password))
        user.confirmed_at = Time.now
        user.save!
      end
      user.identities.create! provider: auth['provider'], token: auth['uid']
    end
    
    sign_in user
    next_url = request.env['omniauth.origin'] || root_path
    next_url = root_path if next_url == new_user_session_url
    redirect_to next_url
  end
end
