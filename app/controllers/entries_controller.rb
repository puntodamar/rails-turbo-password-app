class EntriesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_entry, only: %i[show destroy edit update]

    def new
        @entry = Entry.new
    end

    def show
        if @entry.present?
            respond_to do |format|
                format.html {render "entries/show"}
                format.turbo_stream {}
            end
        else
            flash[:alert] = "Entry Not Found"
            redirect_back(fallback_location: root_path)
        end

    end

    def index
        @entries = current_user.entries.search(params)
        p @entries
        @main_entry = @entries.first
    end

    def create
        @entry = current_user.entries.new(entry_params)
        if @entry.save
            @main_entry = @entry
            flash.now[:notice] = "<strong>#{@entry.name}</strong> has been saved!".html_safe
            respond_to do |format|
                format.html {redirect_to root_path}
                format.turbo_stream {}
            end

        else
            # flash[:alert] = @entry.errors.full_messages
            render :new, status: :unprocessable_content
        end
    end

    def destroy
        if @entry.destroy
            @main_entry = current_user.entries.last
            flash.now[:notice] = "<strong>#{@entry.name}</strong> has been deleted!".html_safe
            respond_to do |format|
                format.html {redirect_to :root_path}
                format.turbo_stream {}
            end
        else
            flash.now[:alert] = "Could not delete <strong>#{@entry.name}</strong>.".html_safe
            respond_to do |format|
                format.html {redirect_to :root_path}
                format.turbo_stream {}
            end
        end
    end

    def edit
    end

    def update
        if @entry.update(entry_params)
            flash.now[:notice] = "<strong>#{@entry.name}</strong> has been updated".html_safe
            respond_to do |format|
                format.html {redirect_to :root_path}
                format.turbo_stream {}
            end
        else
            render :edit, status: :unprocessable_content
        end
    end

    private

    def entry_params
        # params.require(:entry).permit(:name, :url, :username, :password)
        params.expect(entry: [:name, :url, :username, :password])
    end

    def set_entry
        @entry = current_user.entries.find_by_id(params[:id])
    end
end