class Api::UsersController < ApplicationController
	require 'securerandom'

	EXP = Time.now.to_i + 4 * 5000
	def signup
		email = params[:email]	
		checkUser = User.find_by(email: email)

		if checkUser
			p checkUser.wallet
			render json: {msg: 'User already exsist'}
		else

			newUser = User.new(userParams)
			if newUser.save!
				addres = SecureRandom.hex(20)
				p addres
				newUser.build_wallet(ballance: 50, wallet_address: addres).save!
				payload = {
					user: {
						id: newUser.id
					},
					exp: EXP
				}
				token = auth(newUser)
				render json: {token: token}
		end
  end

end
		


    private 
    SECRET_KEY = 'codesalley'
    ALG = 'HS512'

    def auth(data)
				token = JWT.encode data, SECRET_KEY, ALG
				return token 
    end

    def authUser(token)

    end

		def userParams
			params.require('user').permit(:name, :email, :password, :pin)
		end

end