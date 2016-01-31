# Avoids timing attacks using Devise secure find
module SecureFind
  def secure_find_resource_by(resource_class, attribute, value)
    found_instance_id = nil
    resource_class.pluck(:id, attribute).each do |instance|
      if Devise.secure_compare(instance.second, value)
        found_instance_id = instance.first
      end
    end
    resource_class.find_by(id: found_instance_id)
  end
end
