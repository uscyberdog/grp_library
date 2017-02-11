class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    puts book_params

    respond_to do |format|
      if @book.save # new book in master library
        @personal_book = PersonalBook.new
        @personal_book.user_id = session[:user_id]
        @personal_book.book_id = @book.id
        @personal_book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
      else # book already exists in master library - only add to User's personal book db
        @personal_book = PersonalBook.new
        @personal_book.user_id = session[:user_id]
        masterlib_book = Book.find_by_gr_book_id(@book.gr_book_id)
        @personal_book.book_id = masterlib_book.id
        @personal_book.save
        format.html { redirect_to @book, notice: 'Book was found in Master Library and has been added to your library.' }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def lookup
    # look up isbn on goodreads
    response = GoodreadsService.new(params[:isbn]).formatted_response
    puts "*********************response: #{response}"
    puts response == "failed"
    if response == "failed"  # lookup failed
      @book = Book.new
      @book.errors.add(:isbn, :not_specified, message: "is invalid")
    else # lookup was successful
      @book = Book.new(response)
    end
    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.fetch(:book, {}).permit(:title, :description, :gr_book_id, :gr_avg_rating, :num_pages, :gr_link, :author, :gr_author_id, :isbn, :book_cover_photo_med, :book_cover_photo_sm, :pub_date)
    end
end


