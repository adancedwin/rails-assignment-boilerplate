# frozen_string_literal: true

class BooksController < ApplicationController
  include Helpers::BookHelper

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
    result = Services::Books::Creator.new.call(book_params.to_h)
    if result.success?
      redirect_to books_path, status: 303
    else
      render turbo_stream: turbo_stream.replace(
        'errors',
        partial: 'books/shared/errors',
        locals: { errors: result.errors }
      )
    end
  end

  def add_author
    render turbo_stream: turbo_stream.replace('author', partial: 'books/shared/add_author')
  end

  def select_author
    render turbo_stream: turbo_stream.replace(
      'author',
      partial: 'books/shared/select_author',
      locals: { authors: authors_for_select }
    )
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
    params.fetch(:book, {})
          .permit(:title, :cover, :shelf, author: %i[id name])
  end
end
