# coding: utf-8

class EntriesController < ApplicationController
  def create
    begin
      @playlist = Playlist.find(params[:playlist_id])
      @music_id = params[:music_id]

      respond_to do |format|
        if @playlist.entries.select(:music_id).map(&:music_id).include? @music_id.to_i
          @playlist.delete_entry(@music_id)
          @playlist.save
          format.js { render :js => "$('.adding span').last().text('✘').removeClass('added').addClass('deleted').effect('pulsate', {times: 3}, 300);
                                    setTimeout(window.closeMenu, 1500);"}
        else
          @playlist.add_entry(@music_id)
          @playlist.save
          format.js { render :js => "$('.adding span').last().text('✔').removeClass('deleted').addClass('added').effect('pulsate', {times: 3}, 300);
                                    setTimeout(window.closeMenu, 1500);"}
        end
      end
=begin
      @playlist.update_entry(params[:music_id])
      @playlist.save
      respond_to do |format|
        format.js { render :js => "$('.adding td').last().text('✔').css({'color': '#66CD00', 'font-size': '24px'}).effect('pulsate', {times: 3}, 300);
                                    setTimeout(window.closeMenu, 1500);"}
      end
=end
    rescue ActiveRecord::RecordNotFound

    end

  end

  def delete
  end

end
