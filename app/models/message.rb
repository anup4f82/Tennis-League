require 'twilio-ruby'
class Message < ActiveRecord::Base
	belongs_to :user
end


def text(phone1,phone2,responsename,contactname)
  phone1 = '1'+phone1
  phone2 = '1'+phone2

  client = Twilio::REST::Client.new account_sid, auth_token
  from = "13158832240"
  client.account.messages.create(:from => from,:to => phone1 ,:body => " Hi #{contactname}, #{responsename} has accepted your invitation.Have fun on the courts!")
end
