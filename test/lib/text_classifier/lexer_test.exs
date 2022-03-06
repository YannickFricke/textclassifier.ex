defmodule TextClassifier.LexerTest do
  use BasicTestHelper, TextClassifier.Lexer

  alias TextClassifier.Token

  # test "lexer should tokenize a simple string" do
  #   input = "hello world"

  #   assert Lexer.lex_string(input) == [
  #            Token.string_token("hello"),
  #            Token.string_token("world")
  #          ]
  # end

  test "lexer should tokenize a number" do
    assert Lexer.lex_string("123") == [Token.number_token("123")]
  end

  test "lexer should tokenize a negative number" do
    assert Lexer.lex_string("-123") == [Token.number_token("123", negative: true)]
  end

  test "lexer should tokenize a string" do
    assert Lexer.lex_string("exunit") == [Token.string_token("exunit")]
  end

  test "lexer should tokenize a complex string" do
    assert Lexer.lex_string("unit-testing") == [
             Token.string_token("unit"),
             Token.special_character_token("-"),
             Token.string_token("testing")
           ]
  end

  # test "lexer should tokenize a complex string" do
  #   input = """
  #   Hello world!
  #   How are you?
  #   Everything is fine for me (but thanks for asking)
  #   """

  #   assert Lexer.lex_string(input) == [
  #            "Hello",
  #            "world",
  #            "!",
  #            "How are you",
  #            "?",
  #            "Everything is fine for me",
  #            "(",
  #            "but thanks for asking",
  #            ")"
  #          ]
  # end
end
