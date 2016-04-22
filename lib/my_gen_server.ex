defmodule MyGenServer do

  @doc """
  Spawns a new MyGenServer process which can be further referenced by `name`

  `name` is normally an atom and will be used as an alias of a process' pid
  `f` is a function that the programmer using MyGenServer will have to implement
  `state` is the initial state of the MyGenServer process
  """
  def start(name, f, state) do
    fn -> loop(name, f, state) end
    |> spawn
    |> Process.register(name)
  end

  @doc """
  Stop the MyGenServer process execution
  """
  def stop(name), do: send name, :stop

  @doc """
  Communicate with the MyGenServer process identified by `name`

  The function `loop` implements the other side of this communication.
  """
  def call(name, query) do
    send name, {self(), query} #a

    receive do                 #b
      {^name, reply} -> reply
    end
  end

  @doc """
  The "main" routine of the MyGenServer

  Receive a request (a message sent from `call` function), process
  it and send back a response.
  """
  def loop(name, f, state) do
    receive do                             #c
      :stop ->
        nil
      {pid, query} ->
        {reply, state1} = f.(query, state) # this is important!
        send pid, {name, reply}            #d
        loop(name, f, state1)              # tail-call to wait on #b again!
    end
  end

end
