defmodule Scheme do
  def start do
    Scheme.DefinitionTable.start_link

    Scheme.Reader.read
  end
end
