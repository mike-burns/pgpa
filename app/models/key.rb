require 'hkp'

class Key < ActiveRecord::Base
  belongs_to :user
  has_many :uids

  def update_uids!
    update_key!
    parsed_uids.each do |parsed_uid|
      uids.create_or_update!(parsed_uid)
    end
  end

  def public_key
    ctx.keys.detect {|key| key.sha == keyid }
  end

  private

  def update_key!
    raw_pub_key = hkp.fetch(keyid)
    GPGME::Key.import(raw_pub_key)
    update!(raw: raw_pub_key)
  end

  def parsed_uids
    public_key.uids
  end

  def ctx
    GPGME::Ctx.new
  end

  def hkp
    Hkp.new
  end
end
