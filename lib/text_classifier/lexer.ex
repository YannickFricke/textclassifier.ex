defmodule TextClassifier.Lexer do
  alias TextClassifier.Token

  require TextClassifier.Token

  @numbers Enum.map(?0..?9, &<<&1>>)

  @opening_bracket_characters [
    "(",
    "[",
    "{"
  ]

  @closing_bracket_characters [
    ")",
    "]",
    "}"
  ]

  @ambiguous_bracket_characters [
    "\"",
    "'",
    "`"
  ]

  @bracket_character @opening_bracket_characters ++
                       @closing_bracket_characters ++
                       @ambiguous_bracket_characters

  @special_characters [
    "@",
    "€",
    "!",
    "+",
    "-",
    "*",
    "/",
    "~",
    "#",
    "$",
    "%",
    "&",
    "=",
    ".",
    ";",
    "-",
    "_"
  ]

  @initial_lex_accumulator %{
    current_token: nil,
    brackets: %{},
    ambiguous_brackets: %{},
    tokens: []
  }

  @spec lex_string(input :: String.t()) :: list()
  def lex_string(input) do
    input
    |> String.codepoints()
    |> parse_parts()
  end

  defp parse_parts(string_parts, acc \\ @initial_lex_accumulator)

  @spec parse_parts(
          string_parts :: list(String.t()),
          acc :: %{
            current_token: Token.t() | nil,
            brackets: map(),
            ambiguous_brackets: map(),
            tokens: list(Token.t())
          }
        ) :: list()
  defp parse_parts([], %{tokens: tokens, current_token: current_token}),
    do: tokens ++ [current_token]

  # defguard is_test?(token)
  #          when is_struct(token, TextClassifier.Token) and token.type == :string

  defp parse_parts([current_character | rest], %{current_token: current_token} = acc)
       when current_character in @numbers do
    parse_parts(rest, %{
      acc
      | current_token:
          TextClassifier.TokenMerger.merge_token(
            current_token,
            Token.number_token(current_character)
          )
    })
  end

  defp parse_parts(
         [current_character | rest],
         %{current_token: current_token, tokens: tokens, brackets: brackets} = acc
       )
       when current_character in @special_characters do
    parse_parts(rest, %{
      acc
      | current_token: nil,
        tokens: tokens ++ [current_token, Token.special_character_token(current_character)]
    })
  end

  defp parse_parts(
         [current_character | rest],
         %{current_token: current_token, brackets: brackets} = acc
       )
       when current_character in @opening_bracket_characters do
    parse_parts(rest, %{
      acc
      | current_token:
          TextClassifier.TokenMerger.merge_token(
            current_token,
            Token.bracket_token(current_character, opening: true)
          ),
        brackets: increase_bracket_count(brackets, current_character)
    })
  end

  defp parse_parts(
         [current_character | rest],
         %{current_token: current_token, brackets: brackets} = acc
       )
       when current_character in @closing_bracket_characters do
    parse_parts(rest, %{
      acc
      | current_token:
          TextClassifier.TokenMerger.merge_token(
            current_token,
            Token.bracket_token(current_character, closing: true)
          ),
        brackets: decrease_bracket_count(brackets, current_character)
    })
  end

  defp parse_parts(
         [current_character | rest],
         %{current_token: current_token, ambiguous_brackets: ambiguous_brackets} = acc
       )
       when current_character in @ambiguous_bracket_characters do
    parse_parts(rest, %{
      acc
      | current_token:
          TextClassifier.TokenMerger.merge_token(
            current_token,
            Token.bracket_token(current_character, opening: true)
          ),
        brackets: Map.update(ambiguous_brackets, current_character, true, fn value -> !value end)
    })
  end

  defp parse_parts(
         [current_character | rest],
         %{current_token: current_token} = acc
       ) do
    parse_parts(rest, %{
      acc
      | current_token:
          TextClassifier.TokenMerger.merge_token(
            current_token,
            Token.string_token(current_character)
          )
    })
  end

  defp increase_bracket_count(brackets, bracket_character),
    do: Map.update(brackets, bracket_character, 1, &(&1 + 1))

  defp decrease_bracket_count(brackets, bracket_character),
    do: Map.update!(brackets, bracket_character, &(&1 - 1))
end
