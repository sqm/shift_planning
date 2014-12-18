require 'spec_helper'

describe ShiftPlanning::AuthenticationKeeper do
  let(:client_stub) { double(connection: '', staff: '') }

  subject(:client) { described_class.new('key', 'username', 'password') }

  before do
    client.instance_variable_set '@client', client_stub
    allow(client_stub.connection).to receive(:authenticated?) { true }
    allow(client_stub.staff).to receive(:get_login) { true }
  end

  it 'should catch expired token error' do
    expect(client).to receive(:login) { true }
    results = [ ->(c) { true }, ->(c) { raise(ShiftPlanning::ApiError.parse(3)) }]
    client.run { |c| results.pop.call(c) }
  end

  it 'should raise api error' do
    expect do
      client.run { |c| raise(ShiftPlanning::ApiError.parse(3)) }
    end.to raise_error(ShiftPlanning::ApiError)
  end
end
