module NavigationHelpers
  include OfficeCal::Application.routes.url_helpers

  def default_url_options
    {:host => "example.com"}
  end
end

RSpec.configuration.include NavigationHelpers
