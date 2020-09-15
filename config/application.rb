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
    
    config.performance_notice = '『お客様へのお願い』<br>・劇場の開場時間は公演開演時間の30分前となります。<br/><br/>'
    
    config.x.admin.troupe_name = '四角'.freeze
    config.x.admin.performance_name = 'おむすび'.freeze
    config.x.admin.performance_url = 'www.omusubi.com'.freeze
    config.x.admin.troupe_url = 'www.shikaku.com'.freeze
    config.x.admin.troupe_mail = 'shikaku@yahoo.co.jp'.freeze
    config.x.admin.enquete_form = 'google.co.jp'.freeze
    config.x.admin.receiver_mail = 'puente.japan@gmail.com'.freeze
    
    config.x.admin2.troupe_name = '三角'.freeze
    config.x.admin2.performance_name = 'おにぎり'.freeze
    config.x.admin2.performance_url = 'www.onigiri.com'.freeze
    config.x.admin2.troupe_url = 'www.sankaku.com'.freeze
    config.x.admin2.troupe_mail = 'aaa@yahoo.co.jp'.freeze
    config.x.admin2.enquete_form = 'google.co.jp'.freeze
    config.x.admin2.receiver_mail = 'puente.japan@gmail.com'.freeze
    
    config.x.ratchetwrench_1.troupe_name = '劇団ラチェットレンチ'.freeze
    config.x.ratchetwrench_1.performance_name = '曇天プラネタリム:Re'.freeze
    config.x.ratchetwrench_1.performance_url = 'http://ratchetwrench.info/report.html'.freeze
    config.x.ratchetwrench_1.troupe_url = 'http://ratchetwrench.info/'.freeze
    config.x.ratchetwrench_1.troupe_mail = 'ratchetwrench.teatro@gmail.com'.freeze
    config.x.ratchetwrench_1.enquete_form = '
    https://docs.google.com/forms/d/1WnCzoX-nF7K3rwnw5wGTgQ2bozakHpoSdjD7KcCZdiU/edit
'.freeze
    config.x.ratchetwrench_1.receiver_mail = 'ratchetwrench.teatro@gmail.com'.freeze


  end
end
