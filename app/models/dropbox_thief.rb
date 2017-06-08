class DropboxThief

  def initialize(client, account_id)
    @client = client
    @account_id = account_id
  end

  def account_info
    client.get_account(account_id)
  end

  def space_allocated
    (((client.get_space_usage.allocation.allocated.to_f / 1024) / 1024) / 1000).round(1)
  end

  def space_used
    (((client.get_space_usage.used.to_f / 1024) / 1024) / 1000).round(2)
  end

  def home_folder_contents
    client.list_folder("").entries
  end

  private
    attr_reader :client, :account_id

end
