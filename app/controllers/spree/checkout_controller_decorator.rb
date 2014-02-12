Spree::CheckoutController.class_eval do
  def delivery_slots
    if params[:date].blank?
      render json: []
    end

    render json: SpreeDeliverySlots.for(Date.parse(params[:date])).map{|s| { id: s.id, name: s.name } }
  end
end
