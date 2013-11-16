class EncryptedMailer < ActionMailer::Base
  default from: SIGNER

  def auth(args)
    @name = args[:name]
    @secret = args[:secret]

    mail(
      to: args[:email],
      subject: 'Authenticate PGP',
      gpg: {
        encrypt: true,
        sign: true,
        keys: { args[:email] => args[:public_key] }
      }
    )
  end
end
