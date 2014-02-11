Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_delivery_resources_to_admin",
                     :insert_bottom => '[data-hook="admin_configurations_sidebar_menu"]',
                     :partial => "spree_delivery_slots/admin/configuration_sidebar_links")
