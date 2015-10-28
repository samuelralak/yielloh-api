class Subdomain
	def self.matches?(request)
    	request.subdomain.present? && request.subdomain.start_with?('api') || request.subdomain.start_with?('api')
  	end
end
