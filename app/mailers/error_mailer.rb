class ErrorMailer < ActionMailer::Base
  layout 'email_layout'

  def shout_exception(exception, params, user, request)
    @exception = exception
    @params = params
    @user = user
    @request = request
    mail(:to => ActionMailer::Base.default[:from], :subject => "BugLog Exception")
  end

end
