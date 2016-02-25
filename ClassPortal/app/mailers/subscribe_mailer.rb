class SubscribeMailer < ApplicationMailer
  default from: "vaibhav.rajadhyaksha@gmail.com"

  def sample_email(user,title)
    @user = user
    mail(to: @user, subject:'Subscribed Course now Active')
  end



end
