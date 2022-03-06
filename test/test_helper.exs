defmodule BasicTestHelper do
  defmacro __using__(module_under_test) do
    quote do
      use TextClassifier.Base
      use ExUnit.Case, async: true

      alias unquote(module_under_test)
    end
  end
end

ExUnit.start()
