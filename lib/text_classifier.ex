defmodule TextClassifier do
  @moduledoc """
  Documentation for `TextClassifier`.
  """

  @external_resource "resources/allowed_tags.txt"

  @allowed_tags File.read!("resources/allowed_tags.txt")
                |> String.split("\n", trim: true)
                |> Enum.filter(&(String.starts_with?(&1, "#") == false))

  @doc """
  Returns the list of all allowed tags

  ## Examples

    ### It should know about places

    iex> Enum.member?(TextClassifier.all_allowed_tags(), "place")
    true

    ### It should know about greetings

    iex> Enum.member?(TextClassifier.all_allowed_tags(), "greeting")
    true
  """
  def all_allowed_tags, do: @allowed_tags
end
