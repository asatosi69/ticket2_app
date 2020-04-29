class ConnectionsController < ApplicationController
  def index
      @stage = Stage.find(10)
      @kinds = @stage.connections
  end

  def update
  end

  def edit
  end
end
