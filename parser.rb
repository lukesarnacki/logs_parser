class Parser
  def initialize(raw_logs)
    @raw_logs = raw_logs
  end

  def logs
    @logs ||= @raw_logs.split("\n")
  end

  def views
    logs
  end

  def unique_views
    logs
  end
end
