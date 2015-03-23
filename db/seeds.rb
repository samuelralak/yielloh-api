admin_user = User.new({
	:email => 'samuelralak@hotmail.com',
	:password => 'activeadmin', 
	:password_confirmation => 'activeadmin'})
admin_user.save!
admin_user.add_role :super_admin

Doorkeeper::Application.create!(
	:name => "Yielloh Web", 
	:redirect_uri => "https://api.yielloh.com"
)

Doorkeeper::Application.create!(
	:name => "Yielloh Droid", 
	:redirect_uri => "https://api.yielloh.com"
)
