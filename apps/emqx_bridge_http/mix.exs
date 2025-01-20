defmodule EMQXBridgeHTTP.MixProject do
  use Mix.Project
  alias EMQXUmbrella.MixProject, as: UMP

  def project do
    [
      app: :emqx_bridge_http,
      version: "0.1.0",
      build_path: "../../_build",
      # config_path: "../../config/config.exs",
      erlc_options: UMP.erlc_options(),
      erlc_paths: UMP.erlc_paths(),
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications
  def application do
    [extra_applications: UMP.extra_applications()]
  end

  def deps() do
    [
      {:emqx, in_umbrella: true},
      {:emqx_resource, in_umbrella: true},
      UMP.common_dep(:ehttpc),
    ]
  end
end
