defmodule ElixirMicroserviceBase.HealthCheckTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ElixirMicroserviceBase.Router

  @opts Router.init([])

  describe "health-check" do
    test "check db" do
      conn = conn(:get, "/health-check")

      conn = Router.call(conn, @opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert resp = conn.resp_body

      assert {:ok,
              [
                %{
                  "error" => nil,
                  "healthy" => true,
                  "name" => "server",
                  "time" => _
                }
              ]} = Jason.decode(resp)
    end
  end
end
