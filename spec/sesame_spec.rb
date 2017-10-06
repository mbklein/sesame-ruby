require 'spec_helper'

RSpec.describe Sesame do
  let(:email)      { 'abc@i-lovecandyhouse.co' }
  let(:password)   { 'super-strong-password' }
  let(:auth_token) { 'd015cf1353d21a14f392835bceb56d53649e447e3aebe440cef9d' }
  let(:device_id)  { 'ABCD12345' }
  let(:client)     { Sesame::Client.new email: email, password: password }

  it 'has a version number' do
    expect(Sesame::VERSION).not_to be nil
  end

  describe Sesame::Client do
    before do
      stub_fixtures('login')
    end

    subject { client }

    it 'logs in' do
      expect(subject).to be_authorized
    end

    it '#inspect does not expose the auth_token' do
      expect(subject.inspect).not_to match(/auth_token/)
    end
  end

  describe Sesame::Sesame do
    before do
      stub_fixtures('login', 'sesames', 'control')
    end

    describe 'all sesames' do
      subject { client.sesames }

      it 'should return a list of sesames' do
        expect(subject.length).to eq(2)
        expect(subject).to all(be_a(Sesame::Sesame))
      end
    end

    describe 'single sesame' do
      subject { client.sesame device_id: device_id }

      it { is_expected.to be_a(Sesame::Sesame) }

      it 'knows its details' do
        expect(subject.device_id).to eq(device_id)
        expect(subject.nickname).to eq('Front door')
        expect(subject.battery).to eq(100)
        expect(subject).to be_unlocked
        expect(subject.state).to eq('unlocked')
        expect(subject).to be_api_enabled
      end

      it 'locks' do
        expect(subject.lock).to be true
      end

      it 'unlocks' do
        expect(subject.unlock).to be true
      end

      it '#inspect' do
        expect(subject.inspect)
          .to match(/nickname: Front door, is_unlocked: true, api_enabled: true, battery: 100/)
      end
    end
  end
end
