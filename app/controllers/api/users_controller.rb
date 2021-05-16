class Api::UsersController < ApplicationController
	require 'securerandom'

	EXP = Time.now.to_i + 4 * 5000
	def signup
		email = params[:email]	
		checkUser = User.find_by(email: email)
		if checkUser
			render json: {msg: 'User already exsist'}
		else
			newUser = User.new(userParams)
			if newUser.save!
				addres = SecureRandom.hex(20)
				newUser.build_wallet(ballance: 50, wallet_address: addres).save!
				token = auth(newUser)
				render json: {wepay: token}
			end
  	end
	end

	def me 
		token =  request.headers[:wepay]
		if authUser(token) != false 
			user = authUser(token)
			id =	user['user']['id']
			currentUser = User.find_by(id: id)
			render json: [currentUser, currentUser.wallet]
		else
			render json: {msg: 'invalid credentails'}, status: 401
		end
	end

	def signin
		email, password =  params[:email], params[:password]
		p password
		findUser = User.find_by(email: email)
		if !findUser || findUser.password != password
			render json: {msg: 'invalid credentials'}
		elsif findUser.password ==  password
			wepay = auth(findUser)
			render json: {wepay: wepay}

		end
	end
		
    private 
    SECRET_KEY = 'codesalley'
    ALG = 'HS512'

    def auth(data)
			payload = {
				user: {
					id: data.id
				},
				exp: EXP
			}
				token = JWT.encode payload, SECRET_KEY, ALG
				return token 
    end

    def authUser(token)
			begin
				decoded_token = JWT.decode token, SECRET_KEY, true, { algorithm: ALG }
				return decoded_token[0]
			rescue JWT::DecodeError 
				return false
			end
    end

		def userParams
			params.require('user').permit(:name, :email, :password, :pin)
		end

end