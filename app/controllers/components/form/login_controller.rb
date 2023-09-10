class Components::Form::LoginController < ApplicationController
  def index
    render "index", layout: false
  end
end