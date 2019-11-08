require 'spec_helper'

RSpec.describe Sesame::Api do
  let(:auth_token) { 'd015cf1353d21a14f392835bceb56d53649e447e3aebe440cef9d' }
  let(:device_id)  { 'ABCD12345' }

  let(:test_class) do
    Class.new do
      include Sesame::Api
    end
  end
  subject { test_class.new }

  describe '#get_sesames' do
    before do
      stub_fixtures('sesames')
      subject.auth_token(auth_token)
    end

    let(:sesames) { subject.get_sesames }

    it 'retrieves a list of Sesame locks' do
      expect(sesames.length).to eq(2)
      expect(sesames.first['device_id']).to eq('ABC1234567')
    end
  end

  describe '#get_sesame' do
    before do
      stub_fixtures('sesames')
      subject.auth_token(auth_token)
    end

    let(:sesame) { subject.get_sesame(device_id: device_id) }

    it 'retrieves a single Sesame lock' do
      expect(sesame['locked']).to eq(true)
      expect(sesame['battery']).to eq(100)
      expect(sesame['responsive']).to eq(true)
    end

    it 'raises an error when lock ID is not found' do
      expect { subject.get_sesame(device_id: 'EFGH67890') }
        .to raise_error(Sesame::Error, /BAD_PARAMS/)
    end
  end

  describe '#control_sesame' do
    before do
      stub_fixtures('control')
      subject.auth_token(auth_token)
    end

    it 'should lock' do
      expect { subject.control_sesame(device_id: device_id, command: 'lock') }.not_to raise_error
    end

    it 'should unlock' do
      expect { subject.control_sesame(device_id: device_id, command: 'unlock') }.not_to raise_error
    end

    it 'should not squish' do
      expect { subject.control_sesame(device_id: device_id, command: 'squish') }
        .to raise_error(Sesame::Error, /BAD_PARAMS/)
    end
  end
end
