defmodule TextClassifier.CountryClassifierTest do
  use BasicTestHelper, TextClassifier.CountryClassifier
  alias TextClassifier.CountryClassifier

  test "it should match a country" do
    assert CountryClassifier.classify_input("United States of America (USA)") ==
             ["United States of America (USA)"]
  end
end
