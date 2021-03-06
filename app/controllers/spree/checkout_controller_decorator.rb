module Spree
  CheckoutController.class_eval do
    before_filter :sufficient_loyalty_points, only: [:update], if: -> { params[:state] == 'payment' && !params.has_key?(:apply_store_credit)}

    private

    def sufficient_loyalty_points
      if params[:use_existing_card] == 'yes'
        payment_method_ids = [Spree::CreditCard.find_by(id: params[:order]['existing_card']).payment_method_id]
      else
        payment_method_ids = params[:order][:payments_attributes].collect do |payment|
          payment.each do |key, value|
            value.to_i
          end
        end
      end

      if Spree::PaymentMethod.loyalty_points_id_included?(payment_method_ids) && !@order.user.has_sufficient_loyalty_points?(@order)
        flash[:error] = Spree.t(:insufficient_loyalty_points)
        redirect_to spree.checkout_state_path(@order.state)
      end
    end
  end
end
