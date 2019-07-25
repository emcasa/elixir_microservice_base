defmodule ElixirMicroserviceBaseTest do
  use ExUnit.Case
  doctest ElixirMicroserviceBase

  test "greets the world" do
    assert ElixirMicroserviceBase.hello() == :world
  end
end
