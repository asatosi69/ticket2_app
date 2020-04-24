class Ticket < ApplicationRecord
    belongs_to :seller
    belongs_to :stage
    belongs_to :kind
    belongs_to :payment
    
    
    scope :search, -> (search_params) do

        return if search_params.blank?

        seller_id_is(search_params[:seller_id])
        .stage_id_is(search_params[:stage_id])
        .kind_id_is(search_params[:kind_id])
        .payment_id_is(search_params[:payment_id])
        .buyer_name_like(search_params[:buyer_name])
        .buyer_furigana_like(search_params[:buyer_furigana])

    end



    scope :seller_id_is, -> (seller_id) { where(seller_id: seller_id) if seller_id.present? }
    scope :stage_id_is, -> (stage_id) { where(stage_id: stage_id) if stage_id.present? }
    scope :kind_id_is, -> (kind_id) { where(kind_id: kind_id) if kind_id.present? }
    scope :payment_id_is, -> (payment_id) { where(payment_id: payment_id) if payment_id.present? }
    scope :buyer_name_like, -> (buyer_name) { where('buyer_name LIKE ?', "%#{buyer_name}%") if buyer_name.present? }
    scope :buyer_furigana_like, -> (buyer_furigana) { where('buyer_furigana LIKE ?', "%#{buyer_furigana}%") if buyer_furigana.present? }

end
