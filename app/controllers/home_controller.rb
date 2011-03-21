class HomeController < ApplicationController
  #include CrcEstimator
  def index
    cc_session = CrcEstimator.calculated_session
    logger.debug "Session instantiated, #{cc_session.inspect}"
  end
end