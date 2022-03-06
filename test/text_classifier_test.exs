defmodule TextClassifierTest do
  use ExUnit.Case
  doctest TextClassifier

  @spoken_language_tags ~w(
    noun
    verb
    article
    adjective
    pronoun
    numeral
    adverb
    preposition
    conjunction
    interjection
  )

  test "it should contain all spoken language tags" do
    assert Enum.all?(@spoken_language_tags, &Enum.member?(TextClassifier.all_allowed_tags(), &1))
  end
end
