$:.unshift File.expand_path("../../lib/", __FILE__)

require 'rack/test'
require 'rack/lint'
require 'test/unit'
require 'laws_of_robots_txt'

class LawsOfRobotsTxtTest < Test::Unit::TestCase
  include Rack::Test::Methods

  class MockApp
    attr_reader :called
    def initialize
      @called = false
    end
    def call env
      @called = true
      [200, {}, []]
    end
  end

  def config_dir
    File.expand_path("../fixtures/", __FILE__)
  end
  def mock_app
    @mockapp ||= MockApp.new
  end
  def build_app
    app = mock_app
    app = Rack::Lint.new(app)
    app = LawsOfRobotsTxt::Middleware.new(app, config_dir)
    app = Rack::Lint.new(app)
    app
  end
  def app
    @app ||= build_app
  end
  def assert_status expected
    assert_equal expected, @status
  end
  def assert_body expected
    body_string = ''
    @body.each{|b| body_string << b}
    assert_equal body_string, expected
  end
  def assert_header name, expected
    headers = Rack::Utils::HeaderHash.new(@headers)
    assert_equal headers[name], expected
  end
  def make_request url
    @status, @headers, @body = app.call(Rack::MockRequest.env_for(url))
  end

  def test_requests_pass_through
    make_request "http://www.example.com/foobar"
    assert mock_app.called, "should pass through"
  end

  def test_defined_robots
    make_request "http://www.example.com/robots.txt"
    assert !mock_app.called, "should not pass through"

    assert_status 200
    assert_header "Content-Type", "text/plain"
    assert_body File.read("#{config_dir}/www.example.com.txt")
  end

  def test_undefined_robots
    make_request "http://www.example.net/robots.txt"
    assert !mock_app.called, "should not pass through"

    assert_status 200
    assert_header "Content-Type", "text/plain"
    assert_body <<EOS
# Robots not allowed on this domain
User-Agent: *
Disallow: /
EOS
  end
end

