class DropboxController < ApplicationController

  def auth
    url = authenticator.authorize_url :redirect_uri => redirect_uri
    redirect_to url
  end

  def auth_callback
    auth_bearer = authenticator.get_token(params[:code],
                                      :redirect_uri => redirect_uri)

    token = auth_bearer.token
    account_id = auth_bearer.params["account_id"]
    @client = DropboxApi::Client.new(token)
    @space_allocated = client.get_space_usage.allocation.allocated
    @space_used = client.get_space_usage.used
    @account_info = client.get_account(account_id)

    @home_folder_contents = @client.list_folder("").entries

    # require "pry"; binding.pry
    # client.download()
    # At this stage you may want to persist the reusable token we've acquired.
    # Remember that it's bound to the Dropbox account of your user.
    # Keep this token, you'll need it to initialize a `DropboxApi::Client` object

    # If you persist this token, you can use it in subsequent requests or
    # background jobs to perform calls to Dropbox API such as the following.
  end

  def download(path)
    client.download(path)
  end

  private
  attr_reader :client

  def authenticator
    DropboxApi::Authenticator.new(ENV['DROPBOX_KEY'], ENV['DROPBOX_SECRET'])
  end

  def redirect_uri
    "http://localhost:3000/dropbox/auth_callback"
  end


end
