require 'csv'

binding.pry
CSV.generate do |csv|
  column_names = %w(劇団 公演演目 チケットID 取扱者 公演 チケット種別 支払方法 枚数 予約者名 予約者名フリガナ 予約者Eメール コメント 備考 来場済 アンケート送付)
  csv << column_names
  @tickets.each do |ticket|
    column_values = [
      Rails.application.config.troupe_name,
      Rails.application.config.performance_name,
      ticket.id,
      ticket.seller.name,
      ticket.stage.stage,
      ticket.kind.kind,
      ticket.payment.payment,
      ticket.count,
      ticket.buyer_name,
      ticket.buyer_furigana,
      ticket.buyer_mail,
      ticket.comment1,
      ticket.comment2,
      ticket.visited_flag,
      ticket.enquete_flag
    ]
    csv << column_values
  end
end
