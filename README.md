# nerves_config_ec2

This module configures a [Nerves](https://nerves-project.org/) instance at runtime using
[EC2 instance metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html).

It needs to run early in the [Shoehorn](https://github.com/nerves-project/shoehorn) chain, putting
configuration in the application environment to override the configuration of other modules. 

```elixir
config :shoehorn,
  init: [:nerves_runtime, :nerves_config_ec2, :nerves_init_gadget],
  app: Mix.Project.config()[:app]
```

It currently adds the ssh public keys from the instance keypair to `nerves_firmware_ssh`.
You can set static keys like this: 

```elixir
config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!, ".ssh/authorized_keys"))
  ]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nerves_config_ec2` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nerves_config_ec2, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nerves_config_ec2](https://hexdocs.pm/nerves_config_ec2).
