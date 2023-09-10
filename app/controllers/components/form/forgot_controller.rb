class Components::Form::ForgotController < ApplicationController
  def index
    render "index", layout: false
  end
end