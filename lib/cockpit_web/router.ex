defmodule CockpitWeb.Router do
  use CockpitWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CockpitWeb.Plugs.GetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :browser
    plug CockpitWeb.Plugs.LoginRequired
    plug CockpitWeb.Plugs.VerifyAdmin
  end

  scope "/", CockpitWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", CockpitWeb do
    pipe_through :admin

    resources "/users", UserController
  end
end