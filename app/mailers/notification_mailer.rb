class NotificationMailer < ActionMailer::Base
  default from: 'noreply@highschoolassistant.ro',
         return_path: 'noreply@highschoolassistant.ro'

  APP_NAME = '[HighschoolAssistant]'

  # sends notification email to admin when the import is Donnerstag
  # @param import_type [String]
  #
  # return [NotifictionMailer]
  def csv_successfully_imported(import_type)
    mail to: User.where(role: Role.where(name: 'admin')), subject: "#{APP_NAME} - #{import_type}.capitalize successfully imported"
  end
end
