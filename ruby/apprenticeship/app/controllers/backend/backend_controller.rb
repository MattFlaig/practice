class Backend::BackendController < ApplicationController
  before_action :check_access, except: %i(login validate_login)

  def login
    redirect_to backend_orders_submitted_path if access_allowed?
  end

  private

  def validate_login
    check_and_login('PizzaGrande2', params[:login].try(:[], :login))
    if access_allowed?
      redirect_to backend_orders_submitted_path
    else
      redirect_to backend_orders_login_path
    end
  end

  def check_and_login(correct, pw)
    session[:backend_access] = pw if correct == pw
  end

  def access_allowed?
    session[:backend_access].present?
  end

  def check_access
    check_and_login('PizzaG8', params[:login])
    redirect_to backend_orders_login_path unless access_allowed?
  end
end
