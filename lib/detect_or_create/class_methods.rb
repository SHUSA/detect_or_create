module DetectOrCreate
  module ClassMethods
    def detect_or_create(args={})
      if errors = invalid_arguments(args) and errors.present?
        raise StandardError, "#{errors}"
      end

      found_object = self.first(:conditions => args[:by]) || self.create(args[:by].merge(args[:with]))

      if args[:overwrite_existing] && !found_object.new_record?
        found_object.update_attributes(args[:with])
      end

      found_object
    end

    private

    def required_keys
      [:by]
    end

    def required_types
      { :by => Hash,
        :with => Hash }
    end

    def missing_keys(args)
      required_keys - args.keys
    end

    def mismatched_types(args)
      required_types.collect { |key, type|
        "`#{key}` must be a #{type}" if args[key].present? && !args[key].is_a?(type)
      }.compact.join("\n")
    end

    def invalid_arguments(args)
      case
      when missing_keys(args).present?
        "Missing Arguments: `#{missing_keys(args).join(",")}`"
      when mismatched_types(args).present?
        mismatched_types(args)
      when !args[:by].keys.present?
        "Missing keys to filter by"
      end
    end
  end
end

