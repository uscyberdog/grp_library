class GoodreadsService
	attr_reader :isbn, :client

	def initialize(isbn)
		@isbn = isbn
		@client = Goodreads::Client.new(Goodreads.configuration)
	end

	def search
		# if search results have not been called for, call for them. otherwise, return the existing value.
		@search ||= client.book_by_isbn(isbn)
	end

	def formatted_response
		{
			title: search.title,
			isbn: search.isbn,
			#pub_date: convert_date	
			author: search.authors.author.name,
			gr_author_id: search.authors.author.id,
    	book_cover_photo_med: search.image_url,
    	book_cover_photo_sm: search.small_image_url,
    	description: search.description,
			gr_book_id: search.id,
			gr_avg_rating: search.average_rating,
			num_pages: search.num_pages,
			gr_link: search.link
		}
	end

		
  def converted_date
      pub_yr = search.original_publication_year
    	pub_mth = search.original_publication_month
    	pub_day = search.original_publication_day
    	str_date = "#{pub_yr}/#{pub_mth}/#{pub_day}"
    	date = str_date.s_to_date
    	puts "******************* Converted date is: #{date}"
	end
    
    #@book_title = search.work.original_title

end
