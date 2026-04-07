class PricingController < ApplicationController
  before_action :authenticate_user!

  def index
    @plans = [
      { name: 'Free', price: 0, duration: '1 Hour', features: ['Basic Access', 'Profile Management'], color: '#6b7280' },
      { name: 'Silver', price: 5000, duration: '6 Hours', features: ['All Free Features', 'Priority Support', 'Advanced Features'], color: '#9ca3af' },
      { name: 'Gold', price: 10000, duration: '12 Hours', features: ['All Silver Features', 'Premium Support', 'Full Access'], color: '#f59e0b' }
    ]
  end
end