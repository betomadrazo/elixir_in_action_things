defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  # \\ means a default value
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
      # o su equivalente:
      # fn entry, todo_list_acc ->
      #   add_entry(todo_list_acc, entry)
      # end
    )
  end

  def add_entry(todo_list, entry) do
    # Al mapa que está en entry, agrégale el campo id, que valdrá lo del 3er argumento
    # %{entry | id: auto_id} works only if the id field is already present in the map.
    entry = Map.put(entry, :id, todo_list.auto_id)

    # A Map.put/3 le puedes poner en el segundo argumento un atom o una constante(número), o una variable
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}

    # To the external caller, the entire operation will be atomic. Either will happen or,
    # in case of an error, nothing at all.This is the consequence of inmutability.
    # The effect of adding an entry is visible
    # to others only when the add_entry/2 function finishes and its result is taken
    # into a variable.
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_id, entry} -> entry.date == date end)
    |> Enum.map(fn {_id, entry} -> entry end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    # Actualiza de esta forma:
    # TodoList.update_entry(todo_list, 1, &Map.put(&1, :title, "Nuevo título"))
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
      end
  end

  def delete_entry(todo_list, entry_id) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, _} ->
        Map.delete(todo_list.entries, entry_id)
      end
  end
end


defmodule TodoList.CsvImporter do

  def new(todo_list) do
    get_todo_list(todo_list)
    |> TodoList.new()
  end

  def get_todo_list(file_name) do
    get_from_file(file_name)
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn ([a, b]) -> %{date: convert_str_to_date(a), title: b} end)
  end

  defp get_from_file(file_name) do
    File.read!(file_name)
  end

  defp convert_str_to_date(str_date) do
    str_date = String.split(str_date, "/")
    |> Enum.map(&String.to_integer/1)

    Date.new(Enum.at(str_date, 0), Enum.at(str_date, 1), Enum.at(str_date, 2))
    |> elem(1)
  end
end
