module GrapeApiary
  class Config
    SETTINGS = %i(
      host
      name
      description
      request_headers
      response_headers
      example_id_type
      resource_exclusion
      include_root
    ).freeze

    class << self
      attr_accessor(*SETTINGS)

      def request_headers
        @request_headers ||= []
      end

      def response_headers
        @response_headers ||= []
      end

      def resource_exclusion
        @resource_exclusion ||= []
      end

      def include_root
        @include_root ||= false
      end

      def supported_id_types
        %i(integer uuid bson)
      end

      def example_id_type=(value)
        raise UnsupportedIDType unless supported_id_types.include?(value)

        if value.to_sym == :bson && !Object.const_defined?('BSON')
          raise BSONNotDefinied
        end

        @example_id_type = value
      end

      def example_id_type
        @example_id_type ||= :integer
      end

      def generate_id
        # HACK to avoid new ids for each blueprint generation
        case example_id_type
        when :integer
          # SecureRandom.random_number(1000)
          '4598526796494069462'
        when :uuid
          # SecureRandom.uuid
          '9ab8e7fe-0dce-11e8-ba89-0ed5f89f718b'
        when :bson
          # BSON::ObjectId.new.to_s
          '507f191e810c19729de860ea'
        end
      end
    end
  end
end
