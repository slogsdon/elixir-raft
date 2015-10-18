defmodule State do
  @moduledoc """
  State used by all server types.

  ### Persistent state on all servers

  (Updated on stable storage before responding to RPCs)

  - `current_term`
  - `voted_for`
  - `log`

  ### Volatile state on all servers

  - `commit_index`
  - `last_applied`

  ### Volatile state on leaders

  (Reinitialized after election)

  - `next_index`
  - `match_index`
  """

  @type command :: term
  @type command_index :: pos_integer
  @type server_index :: non_neg_integer

  @typedoc "latest term server has seen (initialized to `0` on first boot, increases monotonically)"
  @type current_term :: non_neg_integer

  @typedoc "`candidate_id` that received vote in current term (or `nil` if none)"
  @type voted_for :: non_neg_integer

  @typedoc "log entries; each entry contains command for state machine, and term when entry was received by leader (first index is `1`)"
  @type log :: [{command_index, command}]

  @typedoc "index of highest log entry known to be committed (initialized to `0`, increases monotonically)"
  @type commit_index :: non_neg_integer

  @typedoc "index of highest log entry applied to state machine (initialized to `0`, increases monotonically)"
  @type last_applied :: non_neg_integer

  @typedoc "for each server, index of the next log entry to send to that server (initialized to leader last log index + 1)"
  @type next_index :: [{server_index, command_index}]

  @typedoc "for each server, index of highest log entry known to be replicated on server (initialized to `0`, increases monotonically)"
  @type match_index :: [{server_index, command_index}]

  @type t :: %__MODULE__{
    current_term: current_term,
    voted_for: voted_for,
    log: log,
    commit_index: commit_index,
    last_applied: last_applied,
    next_index: next_index,
    match_index: match_index
  }

  defstruct current_term: 0,
            voted_for: nil,
            log: [],
            commit_index: 0,
            last_applied: 0,
            next_index: [],
            match_index: []
end
