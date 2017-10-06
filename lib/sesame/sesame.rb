module Sesame
  class Sesame
    include Api

    def initialize(attrs = {})
      @state = attrs
    end

    def device_id
      @state['device_id']
    end

    def nickname
      @state['nickname']
    end

    def unlocked?
      truthy?(@state['is_unlocked'])
    end
    alias is_unlocked unlocked?

    def state
      unlocked? ? 'unlocked' : 'locked'
    end

    def api_enabled?
      truthy?(@state['api_enabled'])
    end
    alias api_enabled api_enabled?

    def battery
      @state['battery'].to_i
    end

    def lock
      control(type: 'lock')
    end

    def unlock
      control(type: 'unlock')
    end

    def inspect
      details = @state.keys.collect { |k| "#{k}: #{send(k.to_sym)}" }.join(', ')
      %(#<#{self.class.name}:#{format('0x%.14x', (object_id << 1))} #{details}>)
    end

    def refresh!
      @state.merge!(get_sesame(device_id: device_id))
      self
    end

    private

    def truthy?(value)
      (value == true) || (value == 'true')
    end

    def control(type:)
      control_sesame(device_id: device_id, type: type)
      refresh!
      true
    end
  end
end
