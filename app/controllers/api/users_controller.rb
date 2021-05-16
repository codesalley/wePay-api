class Api::UsersController < ApplicationController

    def signup
        p params

    end

    private 
    EXP = Time.now.to_i + 4 * 5000
    SECRET_KEY = 'codesalley'
    ALG = 'HS512'

    def auth(data)
      token 

    end

    def authUser()

    end

end