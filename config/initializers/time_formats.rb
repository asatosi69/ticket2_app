# config/initierlizers/time_formats.rb
# 既に定義されているフォーマット
# default => "2014-10-01 09:00:00 +0900"
# long    => "October 01, 2014 09:00"
# short   => "01 Oct 09:00"
# db      => "2014-10-01 00:00:00"

# カスタムフォーマットを定義
Time::DATE_FORMATS[:end_time] = "%Y年%m月%d日 %H時%M分"
Date::DATE_FORMATS[:end_time] = "%Y年%m月d日"
Time::DATE_FORMATS[:start_time] = "%Y年%m月%d日 %H時%M分"
Date::DATE_FORMATS[:start_time] = "%Y年%m月d日"
Time::DATE_FORMATS[:stage_time] = "%Y年%m月%d日 %H時%M分"
Date::DATE_FORMATS[:stage_time] = "%Y年%m月d日"
Time::DATE_FORMATS[:updated_at] = "%Y年%m月%d日 %H時%M分"
