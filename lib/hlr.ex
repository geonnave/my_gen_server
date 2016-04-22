defmodule HLR do
  @moduledoc """
  HLR (Home Location Register) - record the location of a phone user

  Use `i_am_at/2` to store the location of a user and `find/1` to query it
  """

  @doc """
  Start a new MyGenServer with `name` = `:hlr`

  the `f` inside MyGenServer is going to be handle_call/2
  `state` is initialized to an empty map
  """
  def start, do: MyGenServer.start(:hlr, &handle_call/2, %{})

  def stop, do: MyGenServer.stop(:hlr)

  def i_am_at(who, where) do
    MyGenServer.call(:hlr, {:i_am_at, who, where})
  end

  def find(who) do
    MyGenServer.call(:hlr, {:find, who})
  end

  @doc """
  The specific implementation of `f`
  """
  def handle_call({:i_am_at, who, where}, map) do
    {:ok, Map.put(map, who, where)}
  end
  def handle_call({:find, who}, map) do
    {map[who], map}
  end

end
