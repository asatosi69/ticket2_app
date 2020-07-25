class UserMailer < ApplicationMailer
    include Devise::Mailers::Helpers

    default from: "no-reply@gmail.com"

    def confirmation_instructions(record, token, opts={})
      @token = token
      @subdomain = opts[:subdomain]
      binding.pry
      devise_mail(record, :confirmation_instructions, opts)
    end

    def reset_password_instructions(record, token, opts={})
      @token = token
      @subdomain = opts[:subdomain]
      devise_mail(record, :reset_password_instructions, opts)
    end

    def unlock_instructions(record, token, opts={})
      @token = token
      @subdomain = opts[:subdomain]
      devise_mail(record, :unlock_instructions, opts)
    end

    
    def notice_mail_for_create_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      @subdomain = params[:subdomain]
      return if @subdomain.blank?
      mail(
        to: @ticket.buyer_mail,
        bcc: @ticket.seller.email,
        subject: "'#{Rails.configuration.x.send(@subdomain).troupe_name}『#{Rails.configuration.x.send(@subdomain).performance_name}』のご予約、承りました'"
      )
    end

    def notice_mail_for_update_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      @subdomain = params[:subdomain]
      return if @subdomain.blank?
      mail(
        to: @ticket.buyer_mail,
        bcc: @ticket.seller.email,
        subject: "'#{Rails.configuration.x.send(@subdomain).troupe_name}『#{Rails.configuration.x.send(@subdomain).performance_name}』のご予約、内容変更承りました'"
      )
    end

    def notice_mail_for_destroy_ticket(ticket)
      return if ticket.buyer_mail.blank?
      @ticket = ticket
      @subdomain = params[:subdomain]
      return if @subdomain.blank?
      mail(
        to: @ticket.buyer_mail,
        bcc: @ticket.seller.email,
        subject: "'#{Rails.configuration.x.send(@subdomain).troupe_name}『#{Rails.configuration.x.send(@subdomain).performance_name}』のご予約、キャンセル承りました'"
      )
    end
    
    def notice_mail_for_url(seller)
      return if seller.email.blank?
      @seller = seller
      @subdomain = params[:subdomain]
      return if @subdomain.blank?
      mail(
        to: @seller.email,
        subject: "'#{Rails.configuration.x.send(@subdomain).troupe_name}『#{Rails.configuration.x.send(@subdomain).performance_name}』の予約ページのURLをお知らせいたします。'"
        )
      end
    
    def notice_mail_for_enquete(ticket)
    return if ticket.buyer_mail.blank?
    @ticket = ticket
    @subdomain = params[:subdomain]
    return if @subdomain.blank?
    mail(
      to: @ticket.buyer_mail,
      bcc: @ticket.seller.email,
      subject: "'#{Rails.configuration.x.send(@subdomain).troupe_name}『#{Rails.configuration.x.send(@subdomain).performance_name}』への観劇後のアンケートにご協力ください。'"
      )
    end
end
