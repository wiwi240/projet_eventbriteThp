class CheckoutController < ApplicationController
  # Sécurité : impossible de payer sans être connecté
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])

    # IMPORTANT : Stripe exige un entier pur.
    # Exemple : 12.50€ devient 1250 centimes.
    @total_amount = (@event.price * 100).to_i

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price_data: {
          currency: "eur",
          product_data: {
            name: @event.title
          },
          unit_amount: @total_amount
        },
        quantity: 1
      } ],
      mode: "payment",
      # URLs de retour basées sur "resources :checkout"
      success_url: success_checkout_index_url + "?session_id={CHECKOUT_SESSION_ID}&event_id=#{@event.id}",
      cancel_url: cancel_checkout_index_url
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @event = Event.find(params[:event_id])

    # On vérifie si l'utilisateur n'est pas déjà inscrit (éviter doublons si refresh)
    unless @event.users.include?(current_user)
      current_user.update(stripe_customer_id: @session.customer)
      Attendance.create(user: current_user, event: @event, stripe_customer_id: @session.customer)
    end

    redirect_to event_path(@event), notice: "Bravo ! Votre inscription est validée."
  end

  def cancel
    redirect_to root_path, alert: "Le paiement a été annulé."
  end
end
