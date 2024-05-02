# 删除现有数据
Movie.destroy_all
Actor.destroy_all
MovieCast.destroy_all

# 生成模型和数据库表
class Movie < ApplicationRecord
  has_many :movie_casts
  has_many :actors, through: :movie_casts
end

class Actor < ApplicationRecord
  has_many :movie_casts
  has_many :movies, through: :movie_casts
end

class MovieCast < ApplicationRecord
  belongs_to :movie
  belongs_to :actor
end

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :mpaa_rating
      t.string :studio

      t.timestamps
    end
  end
end

class CreateActors < ActiveRecord::Migration[6.1]
  def change
    create_table :actors do |t|
      t.string :name

      t.timestamps
    end
  end
end

class CreateMovieCasts < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_casts do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true
      t.string :character_name

      t.timestamps
    end
  end
end

# 插入数据
# Batman Begins
batman_begins = Movie.create(title: "Batman Begins", year: 2005, mpaa_rating: "PG-13", studio: "Warner Bros.")
christian_bale = Actor.create(name: "Christian Bale")
michael_caine = Actor.create(name: "Michael Caine")
liam_neeson = Actor.create(name: "Liam Neeson")
katie_holmes = Actor.create(name: "Katie Holmes")
gary_oldman = Actor.create(name: "Gary Oldman")
MovieCast.create(movie: batman_begins, actor: christian_bale, character_name: "Bruce Wayne")
MovieCast.create(movie: batman_begins, actor: michael_caine, character_name: "Alfred")
MovieCast.create(movie: batman_begins, actor: liam_neeson, character_name: "Ra's Al Ghul")
MovieCast.create(movie: batman_begins, actor: katie_holmes, character_name: "Rachel Dawes")
MovieCast.create(movie: batman_begins, actor: gary_oldman, character_name: "Commissioner Gordon")

# The Dark Knight
the_dark_knight = Movie.create(title: "The Dark Knight", year: 2008, mpaa_rating: "PG-13", studio: "Warner Bros.")
heath_ledger = Actor.create(name: "Heath Ledger")
aaron_eckhart = Actor.create(name: "Aaron Eckhart")
maggie_gyllenhaal = Actor.create(name: "Maggie Gyllenhaal")
MovieCast.create(movie: the_dark_knight, actor: christian_bale, character_name: "Bruce Wayne")
MovieCast.create(movie: the_dark_knight, actor: heath_ledger, character_name: "Joker")
MovieCast.create(movie: the_dark_knight, actor: aaron_eckhart, character_name: "Harvey Dent")
MovieCast.create(movie: the_dark_knight, actor: michael_caine, character_name: "Alfred")
MovieCast.create(movie: the_dark_knight, actor: maggie_gyllenhaal, character_name: "Rachel Dawes")

# The Dark Knight Rises
the_dark_knight_rises = Movie.create(title: "The Dark Knight Rises", year: 2012, mpaa_rating: "PG-13", studio: "Warner Bros.")
tom_hardy = Actor.create(name: "Tom Hardy")
joseph_gordon_levitt = Actor.create(name: "Joseph Gordon-Levitt")
anne_hathaway = Actor.create(name: "Anne Hathaway")
MovieCast.create(movie: the_dark_knight_rises, actor: christian_bale, character_name: "Bruce Wayne")
MovieCast.create(movie: the_dark_knight_rises, actor: gary_oldman, character_name: "Commissioner Gordon")
MovieCast.create(movie: the_dark_knight_rises, actor: tom_hardy, character_name: "Bane")
MovieCast.create(movie: the_dark_knight_rises, actor: joseph_gordon_levitt, character_name: "John Blake")
MovieCast.create(movie: the_dark_knight_rises, actor: anne_hathaway, character_name: "Selina Kyle")

# 查询数据并输出报告
# 打印电影输出的标题
puts "电影"
puts "======"
puts ""

# 查询电影数据并循环显示电影输出
Movie.all.each do |movie|
  puts "#{movie.title.ljust(20)} #{movie.year} #{movie.mpaa_rating.ljust(8)} #{movie.studio}"
end

# 打印演员阵容输出的标题
puts ""
puts "主要演员"
puts "========"
puts ""

# 查询演员数据并循环显示每部电影的演员阵容输出
Movie.all.each do |movie|
  puts "#{movie.title}"
  movie.actors.each do |actor|
    puts "#{movie.title.ljust(20)} #{actor.name.ljust(20)} #{actor.movie_casts.find_by(movie: movie).character_name}"
  end
  puts ""
end
