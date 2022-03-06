defmodule TextClassifier.CountryClassifier do
  use TextClassifier.Classifier

  alias TextClassifier.Lexer

  @countries_file "resources/countries.txt"
  @external_resource @countries_file

  @all_countries File.read!(@countries_file)
                 |> String.split("\n", trim: true)

  @mapped_countries Enum.map(@all_countries, &String.downcase/1)

  @impl TextClassifier.Classifier
  def classify_input(input) do
    # Check if the whole input is a country
    if Enum.member?(@mapped_countries, String.downcase(input)) do
      [input]
    else
      input
      |> Lexer.lex_string()
    end
  end
end
