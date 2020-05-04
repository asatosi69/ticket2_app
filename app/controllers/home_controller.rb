class HomeController < ApplicationController
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?
    # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは下回った場合、終了フラグを立てる
    before_action :sold_out?


    def top
    end
end
