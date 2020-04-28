require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ticket2App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    
    ### Railsが表示の際に扱うタイムゾーン ←ココ
    config.time_zone = 'Tokyo'

    ### Rails(Activerecord)がDBへのRead・Writeを行う際タイムゾーン ←ココ
    config.active_record.default_timezone = :local
    
    config.troupe_name = '三角'.freeze
    config.performance_name = 'おにぎり'.freeze
    config.performance_url = 'www.onigiri.com'.freeze
    config.performance_notice = '『お客様へのお願い』<br>・劇場の開場時間は公演開演時間の30分前となります。<br/><br/>'
    config.troupe_url = 'www.sankaku.com'.freeze
    config.troupe_mail = 'aaa@yahoo.co.jp'.freeze


  end
end
