class Movie < ApplicationRecord
  belongs_to :director
  searchkick

  include PgSearch::Model
  multisearchable against: [:title, :syllabus]

  pg_search_scope :search_by_title_and_syllabus,
    against: [ :title, :syllabus ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end

# syntax to call the class method, takes one argument
# Movie.search_by_title_and_syllabus(query)
