class Admin::DashboardController < Admin::BaseController

  def index
    @decorator = Decorators::DashboardDecorator.new
  end

end
