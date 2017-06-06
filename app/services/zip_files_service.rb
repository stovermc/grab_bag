class ZipFilesService
  def self.download_zip_files(current_folder)
    Zip::OutputStream.write_buffer(::StringIO.new('')) do |zos|
      current_folder.children.each do |contents|
        files(zos, contents) if contents.class == Binary
        folders(zos, contents) if contents.class == Folder
      end
    end
  end

  def self.files(zos, contents)
    zos.put_next_entry "#{contents.name}-#{contents.id}.#{contents.extension}"
    image_data = Faraday.get(contents.data_url).body
    zos.print image_data
  end

  def self.folders(zos, contents)
    if !contents.children.empty?
      contents.children.each do |child|
        child.class == Binary ? files(zos, child) : folders
      end
    end
  end
end
