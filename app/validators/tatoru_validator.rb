# Usage
#
#     class User < ActiveRecord::Base
#       has_one_attached :profile_picture
#       validates :profile_picture, tatoru: true
#     end
#
class TatoruValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if infected?(value)
      record.errors.add(attribute, :contains_malware)
    end
  end

  def validate_each(record, attribute, _value)
    return true unless record.send(attribute).attached?

    changes = record.attachment_changes[attribute.to_s]
    return true if changes.blank?

    files = Array.wrap(changes.is_a?(ActiveStorage::Attached::Changes::CreateMany) ? changes.attachables : changes.attachable)
    files.each do |file|
      scan = MalwareScan.new(file)
      if scan.result['status'] == 'clean'
        next
      else
        add_error(record, attribute, options[:message].presence || :contains_malware, matches: scan.result['matches'].to_sentence)
        break
      end
    end
  end

  private

  def add_error(record, attribute, type, **attrs)
    key = options[:message].presence || type
    return if record.errors.added?(attribute, key)
    record.errors.add(attribute, key, **attrs)
  end

  class MalwareScan
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def result
      @result ||= scan_file
    end

    private

    def scan_file
      is_string = file.is_a?(String)
      if is_string || file.is_a?(ActiveStorage::Blob)
        blob =
          if is_string
            if Rails.gem_version < Gem::Version.new('6.1.0')
              ActiveStorage::Blob.find_signed(file)
            else
              ActiveStorage::Blob.find_signed!(file)
            end
          else
            file
          end

        tempfile = Tempfile.new(["ActiveStorage-#{blob.id}-", blob.filename.extension_with_delimiter])
        tempfile.binmode

        blob.download do |chunk|
          tempfile.write(chunk)
        end

        tempfile.flush
        tempfile.rewind

        scan = Tatoru::Client::File.scan(tempfile.path)
      else
        scan = Tatoru::Client::File.scan(read_file_path)
      end

      while scan['status'] == 'scanning'
        Timeout.timeout(30) do
          sleep(1.second)
          scan = Tatoru::Client::Scan.status(scan['uuid'])
        end
      end
      
      scan
    end

    def read_file_path
      case file
      when ActionDispatch::Http::UploadedFile, Rack::Test::UploadedFile
        file.path
      when Hash
        File.open(file.fetch(:io)).path
      else
        raise "Something wrong with params."
      end
    end

    def logger
      Rails.logger
    end
  end
end
