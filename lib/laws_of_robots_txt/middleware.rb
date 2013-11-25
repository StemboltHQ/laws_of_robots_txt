require 'rack'

module LawsOfRobotsTxt
  class Middleware
    def initialize app, config_dir
      @app = app
      @robots_files = Hash[Dir[File.join(config_dir, "*.txt")].map do |filename|
        domain = File.basename(filename, ".txt")
        [domain, File.read(filename)]
      end]
    end
    def call env
      if env["PATH_INFO"] == "/robots.txt"
        domain = env["SERVER_NAME"]
        [200, {"Content-Type" => "text/plain"}, [robots_txt(domain)]]
      else
        @app.call(env)
      end
    end
    def robots_txt domain
      if robot_string = @robots_files[domain]
        robot_string
      else
        "# Robots not allowed on this domain\nUser-Agent: *\nDisallow: /\n"
      end
    end
  end
end
