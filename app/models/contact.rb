class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :message,   :validate => true
  attribute :subject,   :validate => true

  append :remote_ip, :user_agent, :session
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => self.subject,
      :to => "bite.ovidiu@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
