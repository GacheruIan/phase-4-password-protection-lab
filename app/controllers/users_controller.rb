class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unproccessable_entity_response


    def create

        user = User.create!(user_params)
        session[:user_id]=user.id
        render json: user
        # if user.valid?
        #     render json: user, status: :created
        # else
        #     render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        # end
    end

    #remain logged in
    def show
        user = User.find_by(id:session[:user_id])
        if user
            render json: user
        else 
            render json: { error:  "User not found" }, status: :unauthorized

        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

    def render_unproccessable_entity_response(error)
        render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity
      end

end

