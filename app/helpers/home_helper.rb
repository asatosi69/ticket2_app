module HomeHelper
    def subdomain2
       @subdomain2 = request.subdomain.to_s.to_sym
       return @subdomain2
       binding.pry
    end
end
