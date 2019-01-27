defmodule ArchiveWeb.Router do
  use ArchiveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    #plug ArchiveWeb.AuthenticationController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ArchiveWeb do
    pipe_through :browser

    resources "/", HomeController, only: [:index]
    get "/about", AboutController, :index
    get "/news", NewsController, :index
    get "/follow", FollowController, :index
    get "/privacy-policy", DocumentsController, :privacy_policy
    get "/terms-and-conditions", DocumentsController, :terms_and_conditions
    #resources "/users", UserController
    #resources "/requests", RequestController
  end

  scope "/auth", ArchiveWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/identity/callback", AuthController, :identity_callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArchiveWeb do
  #   pipe_through :api
  # end
end
