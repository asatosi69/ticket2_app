class HomeController < ApplicationController
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?

    def top
        @subdomain  = request.subdomain.to_s.to_sym
        binding.pry
    end
end
