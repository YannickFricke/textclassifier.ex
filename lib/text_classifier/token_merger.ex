defmodule TextClassifier.TokenMerger do
  use TextClassifier.Base

  import TextClassifier.Token
  alias TextClassifier.Token

  @spec merge_token(
          current_token :: Token.t(),
          next_token :: Token.t()
        ) :: Token.t()
  def merge_token(nil, next_token), do: next_token

  def merge_token(current_token, next_token)
      when is_minus_sign_token(current_token) and is_number_token?(next_token) do
    Token.number_token(
      next_token.value,
      Token.merge_metadata(current_token, next_token, negative: true)
    )
  end

  def merge_token(current_token, next_token)
      when is_number_token?(current_token) and is_number_token?(next_token) do
    Token.number_token(
      merge_values(current_token, next_token),
      Token.merge_metadata(current_token, next_token)
    )
  end

  def merge_token(current_token, next_token)
      when (is_string_token?(current_token) and is_string_token?(next_token)) or
             (is_special_character_token?(current_token) and is_string_token?(next_token)) or
             (is_string_token?(current_token) and is_special_character_token?(next_token)) do
    Token.string_token(
      merge_values(current_token, next_token),
      Token.merge_metadata(current_token, next_token)
    )
  end

  defp merge_values(%Token{value: current_value}, %Token{value: next_value}),
    do: current_value <> next_value
end
