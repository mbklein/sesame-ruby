module Sesame
  class Sesame
    include Api

    def initialize(attrs = {})
      @state = attrs
    end

    def device_id
      @state['device_id']
    end

    def locked?
      truthy?(@state['locked'])
    end
    alias locked locked?

    def state
      locked? ? 'locked' : 'unlocked'
    end

    def battery
      @state['battery'].to_i
    end

    def responsive?
      truthy?(@state['responsive'])
    end
    alias responsive responsive?

    def lock
      control(command: 'lock')
    end

    def unlock
      control(command: 'unlock')
    end

    def inspect
      %(#<#{self.class.name}:#{format('0x%.14x', (object_id << 1))} device_id: #{device_id}>)
    end

    def refresh!
      @state.merge!(get_sesame(device_id: device_id))
      self
    end

    private

    def truthy?(value)
      (value == true) || (value == 'true')
    end

    def control(command:)
      control_sesame(device_id: device_id, command: command)
      refresh!
      true
    end
  end
end
