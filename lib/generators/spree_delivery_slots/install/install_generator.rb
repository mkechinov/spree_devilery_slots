module SpreeDeliverySlots
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_delivery_slots\n"
      end

      def add_stylesheets
        if File.exists?('app/assets/stylesheets/store/all.css')
          inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_delivery_slots\n", :before => /\*\//, :verbose => true
        elsif File.exists?('app/assets/stylesheets/store/all.sass')
          append_file 'app/assets/stylesheets/store/all.sass', "@import store/spree_delivery_slots\n"
        end

        if File.exists?('app/assets/stylesheets/admin/all.css')
          inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_delivery_slots\n", :before => /\*\//, :verbose => true
        elsif File.exists?('app/assets/stylesheets/admin/all.sass')
          append_file 'app/assets/stylesheets/admin/all.sass', "@import admin/spree_delivery_slots\n"
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_delivery_slots'
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts 'Skipping rake db:migrate, don\'t forget to run it!'
         end
      end
    end
  end
end
