require 'securerandom'

class Uid < ActiveRecord::Base
  belongs_to :key
  belongs_to :user

  before_create :set_secret_key

  validates :email, uniqueness: { scope: [:user_id, :key_id] }

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

  def verified_totp?(totp)
    verifier.verify(totp)
  end

  def secret_key_uri
    verifier.provisioning_uri("pgpa - #{self.email}")
  end

  private

  def generate_secret
    key.keyid + SecureRandom.urlsafe_base64(32)
  end

  def set_secret_key
    self.secret_key = ROTP::Base32.random_base32
  end

  def verifier
    ROTP::TOTP.new(secret_key)
  end
end
