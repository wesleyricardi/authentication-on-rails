class Components::Form::RegisterController < ApplicationController
  def index
    render "index", layout: false
  end
end