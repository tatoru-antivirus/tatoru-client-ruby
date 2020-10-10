class TatoruValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if infected?(value)
      record.errors.add(attribute, :contains_malware)
    end
  end

  private

  def infected?(value)
    binding.pry
  end
end
