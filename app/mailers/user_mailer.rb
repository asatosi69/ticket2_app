class UserMailer < ApplicationMailer
    def notice_mail_for_create_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      mail(
        to: @ticket.buyer_mail,
        bcc: @ticket.seller.email,
        subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』のご予約、承りました'"
      )
    end

    def notice_mail_for_update_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      mail(
        to: @ticket.buyer_mail,
        bcc: @ticket.seller.email,
        subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』のご予約、内容変更承りました'"
      )
    end

    def notice_mail_for_destroy_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      mail(
        to: @ticket.buyer_mail,
        bcc: @ticket.seller.email,
        subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』のご予約、キャンセル承りました'"
      )
    end
    
    def notice_mail_for_url(seller)
      return if seller.email.blank?
      @seller = seller
      mail(
        to: @seller.email,
        subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』の予約ページのURLをお知らせいたします。'"
        )
      end
    
    def notice_mail_for_enquete(ticket)
    return if ticket.buyer_mail.blank?
    @ticket = ticket
    mail(
      to: @ticket.buyer_mail,
      bcc: @ticket.seller.email,
      subject: "'#{Rails.application.config.troupe_name}『#{Rails.application.config.performance_name}』への観劇後のアンケートにご協力ください。'"
      )
    end
end
