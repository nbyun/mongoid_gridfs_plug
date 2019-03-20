require_relative 'safe_shell'
module Wand
  def self.wave(path)
    type = parse_type(execute_file_cmd(path))
    type = nil if type =~ /^cannot/i
    type
  end

  def self.executable
    @executable ||= `which file`.chomp
  end

  def self.executable=(path)
    @executable = path
  end

private
  def self.parse_type(output)
    type = output.split(';')[0]
    type = type.strip unless type.nil?
    type
  end

  def self.execute_file_cmd(path)
    SafeShell.execute("#{executable}",
                      "-ibm",
                      "/usr/share/misc/webp_magic:/usr/share/misc/magic",
                      path)
  end
end

