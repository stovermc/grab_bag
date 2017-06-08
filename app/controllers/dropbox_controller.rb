class DropboxController < ApplicationController

  def auth
    url = authenticator.authorize_url :redirect_uri => redirect_uri
    redirect_to url
  end

  def auth_callback
    auth_bearer = authenticator.get_token(params[:code],
                                      :redirect_uri => redirect_uri)
    session[:token] = auth_bearer.token

    account_id = auth_bearer.params["account_id"]

    @theif = DropboxTheif.new(client, account_id)
  end

  def upload_file
    uploader = Uploader.new(client, params, current_user)
    s3_object = uploader.upload_to_s3
    uploader.upload_to_grabbag(s3_object)
    redirect_to users_folder_path(current_user.username, route: 'home')
    flash[:success] = "The file #{params[:file_name]} uploaded to your GrabBag"
  end


  private

    def client
      @client ||= DropboxApi::Client.new(session[:token])
    end

    def authenticator
      DropboxApi::Authenticator.new(ENV['DROPBOX_KEY'], ENV['DROPBOX_SECRET'])
    end

    def redirect_uri
      if Rails.env == 'development'
        "http://localhost:3000/dropbox/auth_callback"
      else
        "https://grabbag.herokuapp.com/dropbox/auth_callback"
      end
    end
end
