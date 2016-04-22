defmodule MyGenServerTest do
  use ExUnit.Case
  doctest MyGenServer

  test "HLR shall work" do
    HLR.start
    assert HLR.i_am_at("frodo", "shire") == :ok
    assert HLR.i_am_at("gandalf", "n/a (roaming)") == :ok
    assert HLR.find("frodo") == "shire"
    assert HLR.find("slender") == nil
    assert HLR.stop == :stop
  end
end
