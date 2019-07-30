require_relative '../log.rb'

RSpec.describe Log do
  it 'is constructed of ip and path' do
    log = Log.new(path: '/index', ip: '8.8.8.8')
    expect(log.ip).to eql('8.8.8.8')
    expect(log.path).to eql('/index')
  end
end
