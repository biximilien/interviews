class ApplicationController < ActionController::API
  # https://stackoverflow.com/questions/35067579/making-jbuilder-work-with-rails-5-api-mode
  include ActionController::ImplicitRender # if you need render .jbuilder
  # include ActionView::Layouts # if you need layout for .jbuilder
end
