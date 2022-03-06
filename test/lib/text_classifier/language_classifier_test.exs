defmodule TextClassifier.LanguageClassifierTest do
  use BasicTestHelper, TextClassifier.LanguageClassifier

  alias TextClassifier.LanguageClassifier

  test "it should resolve 'de' to 'German'" do
    assert LanguageClassifier.resolve_iso_code("de") == "German"
  end

  test "it should resolve 'de-at' to 'German (Austria)'" do
    assert LanguageClassifier.resolve_iso_code("de-at") == "German (Austria)"
  end

  test "it should resolve 'de-ch' to 'German (Switzerland)'" do
    assert LanguageClassifier.resolve_iso_code("de-ch") == "German (Switzerland)"
  end

  test "it should resolve 'en' to 'English'" do
    assert LanguageClassifier.resolve_iso_code("en") == "English"
  end

  test "it should resolve 'es' to 'Spanish (Spain)'" do
    assert LanguageClassifier.resolve_iso_code("es") == "Spanish (Spain)"
  end

  test "it should resolve 'fr' to 'French'" do
    assert LanguageClassifier.resolve_iso_code("fr") == "French"
  end

  test "it should resolve 'it' to 'Italian'" do
    assert LanguageClassifier.resolve_iso_code("it") == "Italian"
  end

  test "it should resolve 'ja' to 'Japanese'" do
    assert LanguageClassifier.resolve_iso_code("ja") == "Japanese"
  end

  test "it should resolve 'ko' to 'Korean (Johab)'" do
    assert LanguageClassifier.resolve_iso_code("ko") == "Korean (Johab)"
  end

  test "it should resolve 'pt' to 'Portuguese'" do
    assert LanguageClassifier.resolve_iso_code("pt") == "Portuguese (Portugal)"
  end

  test "resolve_iso_code should return nil when the language code could not be resolved" do
    assert LanguageClassifier.resolve_iso_code("elixir") == nil
  end

  test "all iso codes should be resolved" do
    assert length(LanguageClassifier.all_iso_codes()) == 124
  end
end
