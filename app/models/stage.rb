class Stage < ApplicationRecord
    has_many :tickets
    has_many :connections, dependent: :destroy
    has_many :kinds, through: :connections, dependent: :destroy
    
    validates :stage, presence: true
    validates :total_seats, presence: true, numericality: { only_integer: true }
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :remaining, presence: true, numericality: { only_integer: true }
    
    # 終了フラグを立てる
    def finished
        self.update(end_flag: true)
    end
    
    # モデル『公演』の残席数を設定する
    def self.remaining_tickets(id, sum)
        total_seats = self.find(id).total_seats
        cnt = total_seats - sum
        self.find(id).update(remaining: cnt)
    end
    
end
