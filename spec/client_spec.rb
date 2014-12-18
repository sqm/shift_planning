require 'spec_helper'

describe ShiftPlanning::Client do
  context 'staff' do
    subject(:client) { described_class.new(ENV['SHIFT_PLANNING_KEY']) }

    it 'should raise argument error' do
      expect{ client.staff.get_login('azaza') }.to raise_error(ArgumentError)
    end

    it 'should raise ApiError' do
      expect{ client.staff.get_login('azaza', 'lalka') }.to raise_error(ShiftPlanning::ApiError)
    end

    context 'logged in' do
      before do
        client.staff.get_login(ENV['SHIFT_PLANNING_STAFF_USERNAME'], ENV['SHIFT_PLANNING_STAFF_PASSWORD'])
      end

      it 'should return skills' do
        expect(client.staff.get_skills).to eq('')
      end

      it 'can logout' do
        expect(client.staff.get_logout).to eq('')
      end
    end
  end
end
