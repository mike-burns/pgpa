require 'securerandom'

class Uid < ActiveRecord::Base
  belongs_to :key

  def self.create_or_update!(parsed_uid)
    uid = find_or_create_by(
      email: parsed_uid.email,
      name: parsed_uid.name,
    )
    uid.update!(revoked: parsed_uid.revoked?)
    uid
  end

  def begin_auth
    update!(secret: generate_secret)

    EncryptedMailer.auth(
      email: email,
      name: name,
      secret: secret,
      public_key: key.public_key
    ).deliver
  end

  def revoke_secret!
    update!(secret: nil, checked: true)
  end

  private

  def generate_secret
    key.keyid + SecureRandom.urlsafe_base64(32)
  end
end
