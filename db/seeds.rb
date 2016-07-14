# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Model.create!([
	{name: 'M5 Plus'},
	{name: 'P5L'},
	{name: 'P5 Mini'},
	{name: 'S6'},
	{name: 'P5W'},
	{name: 'M5 Lite'},
	{name: 'S Plus'},
	{name: 'P3S'},
	{name: 'F103 1GB'},
	{name: 'F103 2GB'},
	{name: 'F103 3GB'},
	{name: 'M4'},
	{name: 'P2S'},
	{name: 'P2M'},
	{name: 'S7'},
	{name: 'M2'},
	{name: 'M3'},
	{name: 'P4S'}
])
Designation.create!([
	{name: 'MUM'},
	{name: 'BH'},
	{name: 'ZSM' },
	{name: 'CBH'},
	{name: 'NONE'}
	])

Role.create!([
	{name: 'superadmin'},
	{name: 'Gionee Admin'},
	{name: 'ND Admin'},
	{name: 'CBH' },
	{name: 'ZSM' },
	{name: 'ASM'},
	{name: 'TSM'}
])

user = User.new :email => 'superadmin@fosem.com', :password => '12345',:first_name => 'Super',:last_name => 'Admin' , :mobile_number => '9650875215' ,:landline_number => '9650875215',:office_number => '9650875215',:role_ids => 1,:location_code => "Super Admin"
user.save!
 





