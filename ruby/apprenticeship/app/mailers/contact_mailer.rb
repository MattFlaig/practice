class ContactMailer < ApplicationMailer
  def contact_email(name, message, email)
    @name = name
    @message = message
    @email = email
    mail(to: 'Pizza alla Grande Berlino <andre@pizzaallagrande.de>',
         reply_to: @email)
  end
end