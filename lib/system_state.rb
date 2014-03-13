module SystemState
  def self.idle_time
    dump = `ioreg -c IOHIDSystem`
    hid_idle_time = dump.match(/"HIDIdleTime" = ([0-9]+)/)[1]
    hid_idle_time.to_i / 1000000000
  end

  def self.screensaver_suppressed?
    dump = `pmset -g`
    !!dump.match(/sleep\s+10 \(sleep prevented/)
  end
end
