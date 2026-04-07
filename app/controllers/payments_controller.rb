class PaymentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def create
  plan = params[:plan]

  amount = case plan
           when 'free' then 0
           when 'silver' then 5000
           when 'gold' then 10000
           end

  if amount == 0
    current_user.update(plan: 'free', plan_expires_at: 1.hour.from_now)
    redirect_to dashboard_path, notice: "Free plan activated for 1 hour!"
    return
  end

  session = Stripe::Checkout::Session.create(
  payment_method_types: ['card', 'upi'],  #qr
  line_items: [{
    price_data: {
      currency: 'inr',
      product_data: { name: "#{plan.capitalize} Plan" },
      unit_amount: amount,
    },
    quantity: 1,
  }],
  mode: 'payment',
  success_url: payment_success_url(plan: plan),
  cancel_url: payment_cancel_url,
)

  redirect_to session.url, allow_other_host: true
end

  def success
    plan = params[:plan]
    expires_at = case plan
                 when 'silver' then 6.hours.from_now
                 when 'gold' then 12.hours.from_now
                 end

    current_user.update(plan: plan, plan_expires_at: expires_at)
    redirect_to dashboard_path, notice: "#{plan.capitalize} plan activated successfully!"
  end

  def cancel
    redirect_to pricing_index_path, alert: "Payment cancelled."
  end

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET'])
    rescue => e
      render json: { error: e.message }, status: 400 and return
    end

    render json: { received: true }
  end
end