class DeletesController < ApplicationController
    
    def index
        @deletes = Delete.all.order(created_at: "DESC")
    end
    
end
