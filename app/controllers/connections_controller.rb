class ConnectionsController < ApplicationController
  def index
      @kinds = Kind.all.order(kind: "ASC")
      @stages = Stage.all.order(stage: "ASC")
  end

  def update
  end

  def edit
  end
end
