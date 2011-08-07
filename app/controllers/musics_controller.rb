class MusicsController < ApplicationController
  skip_before_filter :authorize, :only => [:show]

  # GET /musics
  # GET /musics.json
  def index
    @musics = Music.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @musics }
    end
  end

  # GET /musics/1
  # GET /musics/1.json
  def show
    @music = Music.find(params[:id], :include => [{:comments => :user}, :user])
    if session[:user_id] and @rating = @music.ratings.find_by_user_id(session[:user_id])
      @my_rating = @rating.stars
    end

    unless session[:hits] and session[:hits].include? @music.id
      session[:hits] ||= []
      session[:hits] << @music.id

      @music.hits += 1
      @music.save
    end

    @playlists = Playlist.where(:user_id => session[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music }
    end
  end

  # GET /musics/new
  # GET /musics/new.json
  def new
    @music = Music.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @music }
    end
  end

  # GET /musics/1/edit
  def edit
    @music = Music.find(params[:id])
  end

  # POST /musics
  # POST /musics.json
  def create
    @music = Music.new(params[:music])
    @music.file = params[:file]
    @music.user_id = session[:user_id]
    
    respond_to do |format|
      if @music.save
        format.html { redirect_to my_uploads_url, notice: 'Music was successfully created.' }
        format.json { render json: @music, status: :created, location: @music }
      else
        format.html { render action: "new" }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /musics/1
  # PUT /musics/1.json
  def update
    @music = Music.find(params[:id])

    respond_to do |format|
      if @music.update_attributes(params[:music])
        format.html { redirect_to @music, notice: 'Music was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1
  # DELETE /musics/1.json
  def destroy
    @music = Music.find(params[:id])
    @music.destroy

    respond_to do |format|
      format.html { redirect_to home_url }
      format.json { head :ok }
    end
  end

  def my_uploads
    @musics = Music.where(:user_id => session[:user_id])
    render(:index)
  end

  def search
    @musics = Music.where("author LIKE :str OR title LIKE :str OR description LIKE :str ", :str => '%' + params[:search_str] + '%')
                    .order("average * total_ratings DESC")

    respond_to do |format|
      format.html
      format.json { head :ok }
    end

  end
end
