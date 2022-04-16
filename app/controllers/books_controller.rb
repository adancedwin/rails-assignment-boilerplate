# frozen_string_literal: true

class BooksController < ApplicationController
  has_scope :by_shelf, as: :shelf

  def index
    @books = apply_scopes(Book.includes(:cover_attachment)).all
  end

  def show
    @book = book_resource
  end

  def new
    render(
      locals: Presenters::Books::New.call(book_resource)
    )
  end

  def create
    result = Services::Books::Creator.new.call(book_params)
    if result
      # flash[:notice] = t('messages.created', resource_name: resource_fund.model_name.human)
      # redirect_to fund_url(resource_fund)
      redirect_to books_path
    else
      # flash.now[:error] = t('messages.errors')
      # render action: :new, locals: {
      #   reviewers_collection: reviewers_collection,
      #   preparers_collection: preparers_collection,
      #   team_leaders_collection: team_leaders_collection
      # }
    end
  end

  private

  def book_resource
    @book_resource ||= if params[:id].present?
                         Book.find(params[:id])
                       else
                         Book.new(book_params)
                       end
  end

  def book_params
    params.fetch(:book, {}).permit(:title, :author_id, :cover, :shelf)
  end
end
