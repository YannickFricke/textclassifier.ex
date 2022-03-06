defmodule TextClassifier.Classifier do
  defmacro __using__(_opts) do
    quote do
      use TextClassifier.Base

      @behaviour unquote(__MODULE__)
    end
  end

  @callback classify_input(String.t()) :: list(String.t())
end
