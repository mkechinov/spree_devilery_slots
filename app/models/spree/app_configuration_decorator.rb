Spree::AppConfiguration.class_eval do
  preference :delivery_cut_off_hour, :integer, default: 12
end
