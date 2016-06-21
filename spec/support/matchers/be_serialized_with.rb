module BeSerializedWithMatcher
  class BeSerializedWithMatcher
    attr_reader :expected_attributes, :actual_attributes, :expected_attributes, :missing_attributes

    def initialize(serializer)
      @serializer           = serializer
      attributes            = serializer._attributes
      associations          = serializer._reflections.collect{|r| r.options[:key] || r.name}
      @expected_attributes  = (attributes + associations).map(&:to_s)
    end

    def matches?(json)
      @actual_attributes    = json.keys.map(&:to_s)
      @missing_attributes   = @expected_attributes - @actual_attributes
      @extra_attributes     = @actual_attributes - @expected_attributes

      @expected_attributes == @actual_attributes
    end

    def failure_message
      message =  "Expected attributes: #{@expected_attributes.inspect}\n" +
                 "Actual attributes:   #{@actual_attributes.inspect}\n"


      message += "Missing attributes:  #{@missing_attributes.inspect}\n" if @missing_attributes.present?
      message += "Extra attributes:    #{@extra_attributes.inspect}\n" if @extra_attributes.present?

      message
    end
  end

  def be_serialized_with(serializer)
    BeSerializedWithMatcher.new(serializer)
  end
end

RSpec.configure do |config|
  config.include BeSerializedWithMatcher
end
