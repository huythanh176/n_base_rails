
require 'rails/generators/base'

module NBaseRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../", __FILE__)

      def initializer_file
        directory('controllers', 'app/controllers', force: true)
        directory('models', 'app/models', force: true)
        directory('services', 'app/services', force: true)
        directory('serializers', 'app/serializers', force: true)
        directory('config', 'config', force: true)
        directory('lib', 'lib', force: true)
        directory('log', 'log', force: true)
        directory('db', 'db', force: true)
        directory('public', 'public', force: true)
        directory('spec', 'spec', force: true)
        copy_file('.env', '.env')
        copy_file('.rspec', '.rspec')
        copy_file('.rubocop_disabled.yml', '.rubocop_disabled.yml')
        copy_file('.rubocop_enabled.yml', '.rubocop_enabled.yml')
        copy_file('.rubocop.yml', '.rubocop.yml')
        copy_file('Capfile', 'Capfile')
        copy_file('Gemfile', 'Gemfile', force: true)
        append_to_file(".env", "DATABASE_NAME_DEV: #{Rails.application.class.module_parent_name.underscore}_dev\n")
        append_to_file(".env", "DATABASE_NAME_TEST: #{Rails.application.class.module_parent_name.underscore}_test\n")
        insert_into_file 'config/environments/development.rb', before: /^end/ do
          "  config.hosts << ENV.fetch('ALLOW_HOST')\n"
        end
        insert_into_file 'config/application.rb', before: /\n\s*end\n\s*end\n\z/ do
  " 
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Asia/Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en
          "
        end
      end
    end
  end
end