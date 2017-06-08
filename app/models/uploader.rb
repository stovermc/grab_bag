class Uploader

  def initialize(client, params, current_user)
    @client = client
    @params = params
    @current_user = current_user
  end

  def broken_name
    params[:file_name].split('.')
  end

  def home_folder
    current_user.owned_folders.first
  end

  def upload_to_s3
    client.download(params[:path]) do |file_contents|
      @s3_object = S3_BUCKET.put_object(body: file_contents, key: "uploads/#{SecureRandom.uuid}/#{params[:file_name]}", acl: 'public-read')
   end
   @s3_object
  end

  def upload_to_grabbag(s3_object)
    name = broken_name
    folder = home_folder
    data_url = "https://1701grabbag.s3-us-west-1.amazonaws.com/" + s3_object.key
    Binary.create(folder: folder, name: name[0], extension: name[1], data_url: data_url )
  end

  private
    attr_reader :client, :params, :current_user

end
