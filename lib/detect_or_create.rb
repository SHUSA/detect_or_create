require "detect_or_create/version"
require "detect_or_create/class_methods"

module DetectOrCreate
  def self.included(base)
    base.extend ClassMethods
  end
end


class ActiveRecord::Base
  include DetectOrCreate
end

