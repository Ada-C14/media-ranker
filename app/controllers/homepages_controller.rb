class HomepagesController < ApplicationController
  def index
    @works = Work.all

    @spotlight = Work.spotlight

    WORK_CATEGORIES.each do |category|
      var_name = "@#{category}s"
      instance_variable_set(var_name, Work.by_category(category))
    end
  end
end
