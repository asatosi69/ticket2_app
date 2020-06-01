require 'csv'
CSV.generate do |csv|
  column_names = %w(劇団 公演演目 チケットID 取扱者 公演 チケット種別 消費する席数 料金 支払方法 変動額 枚数 予約者名 予約者名フリガナ 予約者Eメール コメント 備考 来場済 アンケート送付 お支払金額 人数)
  csv << column_names
  @tickets.each do |ticket|
    column_values = [
      Rails.application.config.troupe_name,
      Rails.application.config.performance_name,
      ticket.id,
      ticket.seller.name,
      ticket.stage.stage,
      ticket.kind.kind,
      ticket.kind.seats,
      ticket.kind.price,
      ticket.payment.payment,
      ticket.payment.discount_rate,
      ticket.count,
      ticket.buyer_name,
      ticket.buyer_furigana,
      ticket.buyer_mail,
      ticket.comment1,
      ticket.comment2,
      ticket.visited_flag,
      ticket.enquete_flag,
      (ticket.kind.price + ticket.payment.discount_rate) * ticket.count,
      ticket.kind.seats * ticket.count
    ]
    csv << column_values
  end
end
