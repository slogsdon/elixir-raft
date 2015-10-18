# Raft

A [Raft consensus algorithm](https://raft.github.io/) implementation.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add raft to your list of dependencies in `mix.exs`:

        def deps do
          [{:raft, "~> 0.0.1"}]
        end

  2. Ensure raft is started before your application:

        def application do
          [applications: [:raft]]
        end
