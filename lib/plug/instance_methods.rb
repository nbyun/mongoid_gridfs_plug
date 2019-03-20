module Plug
  def grid
    @grid ||= mongo_client.database.fs
  end

  private
    def assigned_attachments
      @assigned_attachments ||= {}
    end

    def nil_attachments
      @nil_attachments ||= {}
    end

    # IO must respond to read and rewind
    def save_attachments
      assigned_attachments.each_pair do |name, io|
        next unless io.respond_to?(:read)
        io.rewind if io.respond_to?(:rewind)
        grid.delete(send(name).id) rescue nil
        grid.upload_from_stream(send(name).name, io, {
          :file_id      =>send(name).id,
          :content_type => send(name).type,
          :metadata     => { :content_type => send(name).type },
          :write        => {
            :w => 1,
            :j => true
          }
        })
      end
      assigned_attachments.clear
    end

    def nullify_nil_attachments_attributes
      nil_attachments.each_key do |name|
        send(:"#{name}_id=", nil)
        send(:"#{name}_size=", nil)
        send(:"#{name}_type=", nil)
        send(:"#{name}_name=", nil)
      end
    end

    def destroy_nil_attachments
      nil_attachments.each_value do |id|
        grid.delete(id) rescue nil
      end

      nil_attachments.clear
    end

    def destroy_all_attachments
      self.class.attachment_names.map { |name| 
        grid.delete(send(name).id) rescue nil
      }
    end
end

