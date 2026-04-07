require 'prawn'

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  has_one_attached :profile_picture

  def self.from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid
    email = auth.info&.email&.downcase&.strip

    # 1) Fast path: existing OAuth identity.
    user = find_by(provider: provider, uid: uid)
    return user if user

    # 2) Reuse existing account by email when provider returns email.
    user = find_by(email: email) if email.present?

    # 3) If no email is provided (possible with Facebook), create a stable placeholder.
    email ||= "#{provider}-#{uid}@oauth.local"

    # 4) Create new account only when needed, then link provider identity.
    user ||= new(email: email)
    user.provider = provider
    user.uid = uid
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
    user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
    user.save!
    user
  end

  def avatar_url
    profile_picture.attached? ? profile_picture : nil
  end

  def admin?
    role == 'admin'
  end

  def plan_active?
    plan.present? && plan_expires_at.present? && plan_expires_at > Time.current
  end

  def plan_duration
    case plan
    when 'free' then 1.hour
    when 'silver' then 6.hours
    when 'gold' then 12.hours
    end
  end
end