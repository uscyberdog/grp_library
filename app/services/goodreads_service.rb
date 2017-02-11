class GoodreadsService
	attr_reader :isbn, :client

	def initialize(isbn)
		@isbn = isbn
		@client = Goodreads::Client.new(Goodreads.configuration)
	end

	def search_old
		# if search results have not been called for, call for them. otherwise, return the existing value.
	end

	def formatted_response
		# Query GoodReads db using the ISBN with our credentials (client)
		search = client.book_by_isbn(isbn)
		if search.nil?
			# Query failed, return an empty hash
			"failed"
		else # Query was successful
			# Check to see if there is an original title (vs. current title)
			# if so then use original title and publication date
			if search.work.original_title.nil?
			  title = search.title
	    else
	    	title = search.work.original_title
	    end
			
			# some books only have year published so use 01/01/YYYY in those cases
			if search.work.original_publication_year.nil?
			  pub_yr = search.publication_year
	    	pub_mth = search.publication_month || "01"
	    	pub_day = search.publication_day || "01"
	    	str_date = "#{pub_yr}-#{pub_mth}-#{pub_day}"
	    else
			  pub_yr = search.work.original_publication_year
	    	pub_mth = search.work.original_publication_month || "01"
	    	pub_day = search.work.original_publication_day || "01"
	    	str_date = "#{pub_yr}-#{pub_mth}-#{pub_day}"
	    end

	    # Determine if there are multiple authors
	    if search.authors.author[0].nil?  # Only one author
				{
					title: search.work.original_title || search.title,
					isbn: search.isbn,
					pub_date: str_date,
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
			else  # Use primary author listed
				{
					title: search.work.original_title || search.title,
					isbn: search.isbn,
					pub_date: str_date,
					author: search.authors.author[0].name,
					gr_author_id: search.authors.author[0].id,
		    	book_cover_photo_med: search.image_url,
		    	book_cover_photo_sm: search.small_image_url,
		    	description: search.description,
					gr_book_id: search.id,
					gr_avg_rating: search.average_rating,
					num_pages: search.num_pages,
					gr_link: search.link
				}
			end
		end
	end

		
  def convert_date
      pub_yr = search.publication_year
    	pub_mth = search.publication_month
    	pub_day = search.publication_day
    	str_date = "#{pub_yr}-#{pub_mth}-#{pub_day}"
    	"2017-12-01"
    	#date = Date::strptime(str_date,"%Y-%m-%d")
    	#date = date.strftime("%-m-%-d-%Y")  
    	puts "******************* Converted date is: #{str_date}"
	end
end
