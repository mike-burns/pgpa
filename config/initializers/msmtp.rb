ActionMailer::Base.add_delivery_method(
  :msmtp,
  Mail::Sendmail,
  location:  '/usr/bin/msmtp',
  arguments: '-i -t'
)
