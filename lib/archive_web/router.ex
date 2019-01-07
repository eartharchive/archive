defmodule ArchiveWeb.Router do
  use ArchiveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ArchiveWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/about", AboutController, :index
    get "/news", NewsController, :index
    get "/follow", FollowController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArchiveWeb do
  #   pipe_through :api
  # end
end
