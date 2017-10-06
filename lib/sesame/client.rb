module Sesame
  class Client
    include Api

    def initialize(email:, password:)
      login(email: email, password: password)
      @email = email
    end

    def sesames
      get_sesames['sesames'].collect do |sesame_attrs|
        Sesame.new(sesame_attrs).auth_token(@auth_token)
      end
    end

    def sesame(device_id:)
      Sesame.new('device_id' => device_id).auth_token(@auth_token).refresh!
    end

    def inspect
      %(#<#{self.class.name}:#{format('0x%.14x', (object_id << 1))} user: #{@email}>)
    end
  end
end
