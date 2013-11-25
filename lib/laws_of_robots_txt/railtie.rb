module LawsOfRobotsTxt
  class Railtie < Rails::Railtie
    initializer "laws_of_robots_txt.configure_middleware" do |app|
      app.middleware.use LawsOfRobotsTxt::Middleware, Rails.root.join("config/robots/").to_s
    end
  end
end
