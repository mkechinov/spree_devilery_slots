module Spree
  module Admin
    class DeliverySlotsController < ResourceController
      before_action :join_weekdays, only: [:create, :update]

      protected
        def join_weekdays
          params[:delivery_slot][:days] = params[:delivery_slot][:days].join(',') if params[:delivery_slot][:days]
          params[:delivery_slot][:discount_days] = params[:delivery_slot][:discount_days].join(',') if params[:delivery_slot][:discount_days]
        end
    end
  end
end
