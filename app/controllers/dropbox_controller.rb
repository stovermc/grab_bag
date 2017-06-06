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
    @account_info = client.get_account(account_id)

    @space_allocated = (((client.get_space_usage.allocation.allocated.to_f / 1024) / 1024) / 1000).round(1)
    @space_used = (((client.get_space_usage.used.to_f / 1024) / 1024) / 1000).round(2)

    @home_folder_contents = client.list_folder("").entries

  end

  def upload_file
    folder = current_user.owned_folders.first
    broken_name = params[:file_name].split('.')
require "pry"; binding.pry
    client.download(params[:path]) do |file_contents|
     @upload_s3_object = S3_BUCKET.put_object(body: file_contents, key: "uploads/#{SecureRandom.uuid}/#{params[:file_name]}", acl: 'public-read')
     end

    data_url = "https://grabbag1701.s3-us-west-1.amazonaws.com/" + @upload_s3_object.key
    Binary.create(folder: folder, name: broken_name[0], extension: broken_name[1], data_url: data_url )
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
    "http://localhost:3000/dropbox/auth_callback"
  end


end
