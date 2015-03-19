class PagesController < ApplicationController

  def dashboard
    @bug_types = BugType.all
  end
end
