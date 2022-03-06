defmodule TextClassifier.CLI do
  def main(_args \\ []) do
  end
end

defmodule MyTextClassifier do
  use TextClassifier.DSL

  Path.wildcard("./**/*.ex")
  |> IO.inspect(label: "files")
end
