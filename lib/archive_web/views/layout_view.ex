defmodule ArchiveWeb.LayoutView do
  use ArchiveWeb, :view

  def active_class(controller, conn) do

    # query_string = cond do
    #   conn.query_string == "" -> ""
    #   true -> "?#{conn.query_string}"
    # end
    # if ("#{conn.request_path}#{query_string}" === path) do "is-active" else "" end
    if(controller == Phoenix.Controller.controller_module(conn)) do
      "is-active"
    else
      ""
    end

  end
end
