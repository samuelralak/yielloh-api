class Subdomain
	def matches?(req)
		if request.subdomain.start_with?('staging')
			subdomain = 'staging'
			subdomain
		else
			subdomain = 'api'
			subdomain
		end
	end
end
