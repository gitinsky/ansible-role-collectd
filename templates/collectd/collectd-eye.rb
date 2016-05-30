Eye.application 'collectd{% if collectd_suffix|default("") != "" %}-{{ collectd_suffix }}{% endif %}' do
  working_dir '/opt/collectd'
  stdall '/var/log/eye/collectd-stdall{% if collectd_suffix|default("") != "" %}-{{ collectd_suffix }}{% endif %}.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :collectd{% if collectd_suffix|default("") != "" %}_{{ collectd_suffix }}{% endif %} do
    pid_file '/var/run/collectd-eye{% if collectd_suffix|default("") != "" %}-{{ collectd_suffix }}{% endif %}.pid'
    start_command '/opt/collectd/sbin/collectd -f -C /opt/collectd/etc/collectd{% if collectd_suffix|default("") != "" %}-{{ collectd_suffix }}{% endif %}.conf'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
