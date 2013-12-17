class User < ActiveRecord::Base
  has_many :keys
  has_many :uids

  accepts_nested_attributes_for :keys
  accepts_nested_attributes_for :uids

  def self.find_by_secret(secret)
    uid = Uid.where(secret: secret).first
    if uid
      uid.revoke_secret!
      uid.key.user
    end
  end

  def begin_auth
    update_uids!
    uids.each(&:begin_auth)
  end

  private

  def update_uids!
    keys.each(&:update_uids!)
  end
end
