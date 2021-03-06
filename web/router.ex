defmodule BookManagement.Router do
  use BookManagement.Web, :router

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

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

  scope "/", BookManagement do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/sign_in", SessionController, :new
    post "/sign_in", SessionController, :create
    get "/sign_out", SessionController, :delete

    scope "/users" do
      resources "/", UserController
    end

    scope "/books" do
      resources "/", BookController
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", BookManagement do
    pipe_through :api
  end
end
