defmodule LLAdminWeb.Router do
  use LLAdminWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug LLAdminWeb.Plugs.Authenticate
  end

  scope "/", LLAdminWeb do
    pipe_through :browser
    pipe_through :authenticated

    get "/", AppController, :index

    scope "/docs" do
      get "/", PageController, :index
      get "/:slug", PageController, :show
    end

    scope "/cms" do
      get "/", CMSController, :index
    end
  end

  scope "/auth", LLAdminWeb do
    pipe_through :browser

    get "/google/callback", SessionController, :create
    get "/", SessionController, :new
    delete "/", SessionController, :destroy
  end
end
