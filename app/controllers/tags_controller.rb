class TagsController < ApplicationController
  before_filter :find_tag, except: [:index]

  def index
    @tags = Tag.all
  end

  def show
  end

  private
  def find_tag
    @tag = Tag.find(params[:id]) if params[:id]
  end
end