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

  pipeline :authenticate do
    plug :browser
    plug CockpitWeb.Plugs.LoginRequired
  end

  pipeline :dashboard do
    plug :authenticate
    plug :put_layout, {CockpitWeb.DashboardView, :dashboard}
  end

  pipeline :authorize_admin do
    plug CockpitWeb.Plugs.Authorize, :admin
  end

  pipeline :authorize_manager do
    plug CockpitWeb.Plugs.Authorize, :manager
  end

  scope "/", CockpitWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", PageController, :get_login
    post "/login", PageController, :do_login
  end
  scope "/", CockpitWeb do
    pipe_through :authenticate

    get "/settings", PageController, :get_account_settings
    put "/settings", PageController, :update_account_settings
    post "/logout", PageController, :do_logout
  end

  scope "/dashboard", CockpitWeb do
    pipe_through [:dashboard, :authorize_admin]

    post "/nodes/:id/reboot", NodeController, :reboot
    resources "/nodes", NodeController, except: [:index]
    resources "/users", UserController, except: [:index, :show]
  end
  
  scope "/dashboard", CockpitWeb do
    pipe_through [:dashboard, :authorize_manager]
    
    get "/", DashboardController, :index
    resources "/nodes", NodeController, only: [:index]
    resources "/users", UserController, only: [:index, :show]
    resources "/gameservers", GameServerController
  end
end
