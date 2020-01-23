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

  scope "/home", LLAdminWeb do
    pipe_through :browser
    pipe_through :authenticated

    get "/", PageController, :index
  end

  scope "/", LLAdminWeb do
    pipe_through :browser

    get "/auth/google/callback", SessionController, :create
    get "/", SessionController, :new
    delete "/", SessionController, :destroy
  end
end
