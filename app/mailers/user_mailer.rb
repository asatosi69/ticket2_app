class UserMailer < ApplicationMailer
    def notice_mail_for_create_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      mail(
        to: @ticket.buyer_mail,
        subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』のご予約を承りました'"
      )
    end

    def notice_mail_for_update_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      mail(
        to: @ticket.buyer_mail,
        subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』のご予約内容を変更いたしました'"
      )
    end

    def notice_mail_for_destroy_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      mail(
        to: @ticket.buyer_mail,
       subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』のご予約をキャンセルいたしました。'"
      )
    end
end
