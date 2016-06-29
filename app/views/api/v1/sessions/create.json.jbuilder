json.result true
json.status CREATE_SUCCESS_STATUS
json.object do
	json.name @user.first_name+" "+@user.last_name
	json.email @user.email
	json.remember_token @user.remember_token
	json.location_code @user.location_code
end