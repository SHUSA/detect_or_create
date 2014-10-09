module DetectOrCreate
  module ClassMethods

    # Finds or creates an object, based on parameters provided
    #
    # @param args [Hash] Parameters to detect or create
    # @option args [Hash] :by The parameters to use when finding a record
    # @option args [Hash] :with The parameters to use to update or create the record
    # @option args [Boolean] :overwrite_existing Allow overwriting of existing records
    # @return [Object] the updated instantiated or created object
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

    # Sets required keys for argument hash
    #
    # @return [Array] Required keys to be sent in the options hash.
    def required_keys
      [:by]
    end

    # Only allow certain object types with specific keys
    #
    # @return [Hash] Used to set what type of object is allowed with certain parameters
    def required_types
      { :by => Hash,
        :with => Hash }
    end

    # Verify existence of required keys
    #
    # @param args [Hash] Argument hash
    # @return [Array] Required keys that have not been provided as arguments
    def missing_keys(args)
      required_keys - args.keys
    end

    # Verify argument object types match with required_types
    #
    # @param args [Hash] Argument Hash
    # @return [String] Error strings to return to consumer for mismatched key types
    def mismatched_types(args)
      required_types.collect { |key, type|
        "`#{key}` must be a #{type}" if args[key].present? && !args[key].is_a?(type)
      }.compact.join("\n")
    end


    # Validates arguments hash
    #
    # @param args [Hash] Argument Hash
    # @return [String] If invalid, error string is returned
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

