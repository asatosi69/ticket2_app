class ConnectionsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
  def index
      @kinds = Kind.all.order(kind: "ASC")
      @stages = Stage.all.order(stage: "ASC")
  end

  def update
  end

  def edit
  end
end
