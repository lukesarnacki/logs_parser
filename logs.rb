class Logs
  include Enumerable
  attr_reader :deserializer

  def initialize(deserializer: TextLogDeserializer)
    @deserializer = deserializer
    @logs = []
  end

  def append(log)
    @logs << deserializer.parse(log)
  end

  def each
    @logs.each { |log| yield log }
  end
end

module TextLogDeserializer
  def self.parse(line)
    path, ip = line.split(/\s+/)
    Log.new(path: path, ip: ip)
  end
end
