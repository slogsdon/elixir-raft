defmodule Raft.Server do
  @moduledoc """
  """

  alias Raft.Server.State

  @type ref :: atom | {atom, atom} | pid

  @doc """
  Invoked by leader to replicate log entries (§5.3); also used
  as heartbeat (§5.2).

  ## Arguments

  - `ref` - a reference to a Raft server
  - `term` - leader’s term
  - `leader_id` - so follower can redirect clients
  - `prev_log_index` - index of log entry immediately preceding
      new ones
  - `prev_log_term` - term of `prev_log_index` entry
  - `entries` - log entries to store (empty for heartbeat; may
      send more than one for efficiency)
  - `leader_commit` - leader’s `commit_index`

  ## Result

  - `{success, term}` - where:
      - `success` is `:ok` if follower contained entry matching
          `prev_log_index` and `prev_log_term`
      - `term` is `current_term`, for leader to update itself
  """
  @spec append_entries(ref, State.current_term, State.server_index State.command_index, State.command, State.log, State.commit_index) :: {:ok, State.current_term} | {:error, nil}
  def append_entries(ref, term, leader_id, prev_log_index, prev_log_term, entries, leader_commit) do
  end

  @doc """
  Invoked by candidates to gather votes (§5.2).

  ## Arguments

  - `ref` - a reference to a Raft server
  - `term` - candidate’s term
  - `candidate_id` - candidate requesting vote
  - `last_log_index` - index of candidate’s last log entry (§5.4)
  - `last_log_term` - term of candidate’s last log entry (§5.4)

  ## Result

  - `{vote_granted, term}` - where:
      - `vote_granted` - `:ok` means candidate received vote
      - `term` is `current_term`, for candidate to update itself
  """
  @spec request_vote(ref, State.current_term, State.server_index, State.command_index, State.command) :: {:ok, State.current_term} | {:error, nil}
  def request_vote(ref, term, candidate_id, last_log_index, last_log_term) do
  end

  @doc """
  Invoked by admin to add a server to the cluster configuration.

  ## Arguments

  - `ref` - a reference to a Raft server
  - `new_server` - address of server to add to configuration

  ## Result

  - `{status, leader_hint}` - where:
      - `status` - `:ok` if server was added successfully
      - `leader_hint` - address of recent leader, if known
  """
  @spec add_server(ref, ref | binary) :: {:ok, ref | binary}
  def add_server(ref, new_server) do
  end

  @doc """
  Invoked by admin to remove a server from the cluster
  configuration.

  ## Arguments

  - `ref` - a reference to a Raft server
  - `old_server` - address of server to remove to configuration

  ## Result

  - `{status, leader_hint}` - where:
      - `status` - `:ok` if server was removed successfully
      - `leader_hint` - address of recent leader, if known
  """
  @spec remove_server(ref, ref | binary) :: {:ok, ref | binary}
  def remove_server(ref, old_server) do
  end

  @doc """
  Invoked by leader to send chunks of a shapshot to a follower.
  Leaders always send chunks in order.

  ## Arguments

  - `ref` - a reference to a Raft server
  - `term` - leader's term
  - `leader_id` - so follow can redirect clients
  - `last_index` - the snapshot replaces all entries up through
      and including this index
  - `last_term` - term of `last_index`
  - `last_config` - latest cluster configuration as of `last_index`
      (include only with first chunk)
  - `offset` - byte offset where chunk is positioned in the
      snapshot file
  - `data` - raw bytes of the snapshot chunk, starting at offset
  - `done` - `true` if this is the last chunk

  ## Result

  - `term` - `current_term`, for leader to update itself
  """
  @spec install_snapshot(ref, State.current_term, State.server_index, State.command_index, State.command, term, non_neg_integer, list, boolean) :: State.current_term
  def install_snapshot(ref, term, leader_id, last_index, last_term, last_config, offset, data, done) do
  end

  @doc """
  Invoked by clients to modify the replicated state.

  ## Arguments

  - `ref` - a reference to a Raft server
  - `client_id` - client invoking request (§6.3)
  - `sequence_num` - to eliminate duplicates (§6.4)
  - `command` - request for state machine, may affect state

  ## Result

  - `{status, response, leader_hint}` - where:
      - `status` - `:ok` if state machine applied command
      - `response` - state machine output, if successful
      - `leader_hint` - address of recent leader, if known (§6.2)
  """
  @spec client_request(ref, term, term, State.command) :: term
  def client_request(ref, client_id, sequence_num, command) do
  end

  @doc """
  Invoked by new clients to open new session,used to eliminate
  duplicate requests. (§6.3)

  ## Result

  - `{status, client_id, leader_hint}` - where:
      - `status` - `:ok` if state machine applied command
      - `client_id` - unique identifier for client session
      - `leader_hint` - address of recent leader, if known
  """
  @spec register_client(ref) :: term
  def register_client(ref) do
  end

  @doc """
  Invoked by clients to query the replicated state (read-only
  commands). (§6.4)

  ## Arguments

  - `ref` - a reference to a Raft server
  - `query` - request for state machine, read-only

  ## Result

  - `{status, response, leader_hint}` - where:
      - `status` - `:ok` if state machine applied command
      - `response` - state machine output, if successful
      - `leader_hint` - address of recent leader, if known (§6.2)
  """
  @spec client_query(ref, term) :: term
  def client_query(ref, query) do
  end
end
