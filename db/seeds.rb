admin_user = User.new({
	:email => 'samuelralak@hotmail.com',
	:password => 'activeadmin', 
	:password_confirmation => 'activeadmin'})
admin_user.save!
admin_user.add_role :super_admin
