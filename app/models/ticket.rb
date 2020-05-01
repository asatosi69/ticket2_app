class Ticket < ApplicationRecord
    belongs_to :seller
    belongs_to :stage
    belongs_to :kind
    belongs_to :payment
    
    validates :seller_id, presence: true
    validates :stage_id, presence: true
    validates :kind_id, presence: true
    validates :payment_id, presence: true
    
    validates :buyer_name, presence: true,
    format: {
      with: /\A[ぁ-んァ-ヶー一-龠]+\z/,
      errors: "は全角のみで入力して下さい"
    }
    
    validates :buyer_furigana, presence: true,
    format: {
      with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
      errors: "は全角カタカナのみで入力して下さい"
    }
    
    validate :check_conbination_of_stage_and_kind, unless: -> { validation_context == :admin_seller }
    
    scope :search, -> (search_params) do

        return if search_params.blank?
        
        seller_id_is(search_params[:seller_id])
        .stage_id_is(search_params[:stage_id])
        .kind_id_is(search_params[:kind_id])
        .payment_id_is(search_params[:payment_id])
        .buyer_name_like(search_params[:buyer_name])
        .buyer_furigana_like(search_params[:buyer_furigana])
        .comment1_like(search_params[:comment1])
        .comment2_like(search_params[:comment2])

    end

    scope :seller_id_is, -> (seller_id) { where(seller_id: seller_id) if seller_id.present? }
    scope :stage_id_is, -> (stage_id) { where(stage_id: stage_id) if stage_id.present? }
    scope :kind_id_is, -> (kind_id) { where(kind_id: kind_id) if kind_id.present? }
    scope :payment_id_is, -> (payment_id) { where(payment_id: payment_id) if payment_id.present? }
    scope :buyer_name_like, -> (buyer_name) { where('buyer_name LIKE ?', "%#{buyer_name}%") if buyer_name.present? }
    scope :buyer_furigana_like, -> (buyer_furigana) { where('buyer_furigana LIKE ?', "%#{buyer_furigana}%") if buyer_furigana.present? }
    scope :comment1_like, -> (comment1) { where.not(comment1: nil ) if comment1 = 1 }
    scope :comment2_like, -> (comment2) { where.not(comment2: nil ) if comment2 = 1 }

  private

    def check_conbination_of_stage_and_kind
        
      return unless Connection.find_by(stage_id: stage_id, kind_id: kind_id).invalid_flag

      errors.add('選択いただいた『公演 / チケット種別』の組み合わせでは予約を承ることができません。')

    end

end
