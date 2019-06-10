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
    plug :put_layout, {CockpitWeb.DashboardView, :dashboard}
  end

  scope "/", CockpitWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", PageController, :get_login
    post "/login", PageController, :do_login
    post "/logout", PageController, :do_logout
  end

  scope "/dashboard", CockpitWeb do
    pipe_through :admin

    get "/", DashboardController, :index
    post "/nodes/:id/reboot", NodeController, :reboot
    resources "/nodes", NodeController
    resources "/users", UserController
  end
end
