class Payment < ApplicationRecord
    has_many :tickets
    
    validates :payment, presence: true, uniqueness: true,
    format: {
      with: /\A[ぁ-んァ-ヶー一-龠]+\z/,
      message: "は全角のみで入力して下さい"
    }
    validates :abbreviation, presence: true, uniqueness: true, length: { maximum: 3 },
    format: {
      with: /\A[ぁ-んァ-ヶー一-龠]+\z/,
      message: "は全角のみで入力して下さい"
    }
    validates :discount_rate, presence: true, numericality: { only_integer: true }
    
end
