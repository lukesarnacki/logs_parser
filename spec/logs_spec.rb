require_relative '../logs.rb'

RSpec.describe Logs do
  describe '.append' do
    it 'adds a log into a logs collection' do
      module FakeLogDeserializer
        def self.parse(log)
          log
        end
      end

      logs = Logs.new(deserializer: FakeLogDeserializer)

      logs.append('my log 1')
      logs.append('my log 2')

      expect(logs.to_a).to match_array(['my log 1', 'my log 2'])
    end

    context 'with default deserializer' do
      it 'deserializes logs to Log objects' do
        logs = Logs.new

        logs.append('/path1 1.1.1.1')
        logs.append('/path2 2.2.2.2')

        expect(logs.to_a).to match_array(
          [
            Log.new(path: '/path1', ip: '1.1.1.1'),
            Log.new(path: '/path2', ip: '2.2.2.2')
          ]
        )
      end
    end
  end
end
