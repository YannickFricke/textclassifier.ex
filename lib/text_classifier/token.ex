defmodule TextClassifier.Token do
  @enforce_keys [:type, :value, :metadata]
  defstruct [:type, :value, :metadata]

  @type t() :: %__MODULE__{
          type: atom(),
          value: String.t()
        }

  @spec string_token(input :: String.t(), metadata :: Keyword.t()) :: TextClassifier.Token.t()
  def string_token(input, metadata \\ []) when is_binary(input) and is_list(metadata),
    do: create_token(:string, input, metadata)

  @spec is_token(token :: TextClassifier.Token.t()) :: Boolean.t()
  defguard is_token(input) when is_struct(input, TextClassifier.Token)

  defguard is_token_type?(token, token_type)
           when is_token(token) and is_atom(token_type) and token.type == token_type

  defguard is_string_token?(token) when is_token_type?(token, :string)
  defguard is_number_token?(token) when is_token_type?(token, :number)
  defguard is_bracket_token?(token) when is_token_type?(token, :bracket)
  defguard is_special_character_token?(token) when is_token_type?(token, :special_character)

  defguard is_minus_sign_token(token)
           when is_special_character_token?(token) and token.value == "-"

  @spec number_token(input :: String.t(), metadata :: Keyword.t()) :: TextClassifier.Token.t()
  def number_token(input, metadata \\ []) when is_binary(input) and is_list(metadata),
    do: create_token(:number, input, metadata)

  @spec bracket_token(input :: String.t(), metadata :: Keyword.t()) :: TextClassifier.Token.t()
  def bracket_token(input, metadata \\ []) when is_binary(input) and is_list(metadata),
    do: create_token(:bracket, input, metadata)

  @spec special_character_token(input :: String.t(), metadata :: Keyword.t()) ::
          TextClassifier.Token.t()
  def special_character_token(input, metadata \\ []) when is_binary(input) and is_list(metadata),
    do: create_token(:special_character, input, metadata)

  # def merge_token(current_token, nil), do: current_token

  def merge_metadata(
        %__MODULE__{metadata: current_metadata},
        %__MODULE__{metadata: next_metadata},
        new_metadata \\ []
      )
      when is_list(new_metadata) do
    current_metadata
    |> Keyword.merge(next_metadata)
    |> Keyword.merge(new_metadata)
  end

  @spec create_token(type :: atom(), input :: String.t(), metadata :: Keyword.t()) :: Token.t()
  defp create_token(type, input, metadata) when is_atom(type) and is_binary(input),
    do: %__MODULE__{
      type: type,
      value: input,
      metadata: metadata
    }
end
