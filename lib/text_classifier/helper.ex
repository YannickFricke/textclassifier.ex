defmodule TextClassifier.Helper do
  def clean_language_name(language) do
    String.replace(language, " (Standard)", "")
  end
end
