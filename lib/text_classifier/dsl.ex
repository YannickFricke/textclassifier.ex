defmodule TextClassifier.DSL do
  @callback get_classifier() :: map()

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)

      @behaviour unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      @impl unquote(__MODULE__)
      def get_classifier() do
        %{}
      end
    end
  end
end
