defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new, do: %TodoList{}

  def add_entry(todo_list, entry) do
    # Al mapa que está en entry, agrégale el campo id, que valdrá lo del 3er argumento
    entry = Map.put(entry, :id, todo_list.auto_id)

    # A Map.put/3 le puedes poner en el segundo argumento un atom o una constante(número), o una variable
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end
end
