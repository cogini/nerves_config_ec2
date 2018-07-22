defmodule NervesConfigEc2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    add_ssh_keys()

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: NervesConfigEc2.Worker.start_link(arg)
      # {NervesConfigEc2.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NervesConfigEc2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp add_ssh_keys do
    static = Application.get_env(:nerves_firmware_ssh, :authorized_keys, [])

    instance = case :httpc.request('http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key') do
      {:ok, {_, _, ""}} ->
        []
      {:ok, {_, _, key}} ->
        [key]
      _ ->
        []
    end
    Application.put_env(:nerves_firmware_ssh, :authorized_keys, static ++ instance)
  end

end
