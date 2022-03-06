defmodule TextClassifier.LanguageClassifier do
  @moduledoc """
  """
  @language_codes_file "resources/language_codes.txt"

  @external_resource @language_codes_file

  @mapped_language_codes File.read!(@language_codes_file)
                         |> String.split("\n", trim: true)
                         |> Enum.map(fn line ->
                           [iso_code, language_name] = String.split(line, "|", trim: true)

                           [iso_code, TextClassifier.Helper.clean_language_name(language_name)]
                         end)
                         |> Enum.map(&List.to_tuple/1)
                         |> Enum.into(%{})

  @spec resolve_iso_code(String.t()) :: String.t() | nil

  for iso_code <- Map.keys(@mapped_language_codes) do
    def resolve_iso_code(unquote(iso_code)),
      do: unquote(Map.get(@mapped_language_codes, iso_code))
  end

  def resolve_iso_code(_), do: nil

  @spec all_iso_codes :: list(String.t())
  def all_iso_codes, do: Map.keys(@mapped_language_codes)
end
