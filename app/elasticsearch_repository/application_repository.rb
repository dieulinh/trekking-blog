# frozen_string_literal: true

# require 'elasticsearch_rails_extensions'

class ApplicationRepository < Elasticsearch::Persistence::Repository::Class
  def initialize(options = {})
    @options = options
    client Elasticsearch::Client.new url: "http://ec2-54-255-208-1.ap-southeast-1.compute.amazonaws.com:9200", log: true

    index_name [Rails.application.engine_name, Rails.env, self.class.name].map(&:downcase).join('_').gsub!('::', '__')
    #type [Rails.application.engine_name, Rails.env, self.class.name].map(&:downcase).join('_').gsub!('::', '__')
    klass self.class

    setting_repository
    block.arity < 1 ? instance_eval(&block) : yield(self) if block_given?

  end


  def self.index_name
    [Rails.application.engine_name, Rails.env, name].map(&:downcase).join('_').gsub!('::', '__')
  end

  def setting_repository
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def deserialize(document)
    super(document)
  end

  def serialize(document)
    super(document)
  end
end
