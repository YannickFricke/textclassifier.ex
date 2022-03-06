defmodule TextClassifier.Base do
  defmacro __using__(_opts) do
    quote do
      require Logger
    end
  end
end
