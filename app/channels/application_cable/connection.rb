module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      query_params = request.query_parameters
      uid = query_params[:uid]
      client_id = query_params[:client_id]
      token = query_params[:token]

      user = User.find_by(uid: uid)

      if user&.valid_token?(token, client_id)
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
