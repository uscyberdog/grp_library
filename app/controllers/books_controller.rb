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
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
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
    isbn = params[:isbn]
    puts "**************** ISBN is: #{isbn}"
    # look up isbn on goodreads
    client = Goodreads::Client.new(:api_key => 'UWJCblTbuvlJVdQBLENkOg', :api_secret => 'AbgCapvYysV18BxtnX65bL2pFvr63cky7MEO1GWv0k')
    Goodreads.configuration
    search = client.book_by_isbn(isbn)
    @book = Book.new
    @book.author = search.authors.author.name
    @book.gr_author_id = search.authors.author.id
    @book.isbn = search.isbn
    @book.book_cover_photo_med = search.image_url
    @book.book_cover_photo_sm = search.small_image_url
    @book.title = search.title
    #@book_title = search.work.original_title
    @book.description = search.description  # may have imbedded html 
    puts "********************* Description: #{@book.description}"
    @book.gr_book_id = search.id
    #pub_yr = search.original_publication_year
    #pub_mth = search.original_publication_month
    #pub_day = search.original_publication_day
    #@book.pub_date = convert_date(pub_yr, pub_mth, pub_day)
    @book.gr_avg_rating = search.average_rating
    @book.num_pages = search.num_pages
    @book.gr_link = search.link
    puts "**************Title: #{@book.title} by #{@book.author}"
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


