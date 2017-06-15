class CataloguesController < ApplicationController
  def index
  end

  def pdf
    # pdf_filename = File.join(Rails.root, "app/assets/images/spirit sp 17catalog.pdf")
    # send_file(pdf_filename, :filename => "spirit sp 17catalog.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def show
    @account = params[:id]
    # get brand name from URL (Don't ever do this in RL)
    # create the UL/LI structure here, because it can be easily recursive here
    def directory_hash(path, name=nil, exclude = [])
      exclude.concat(['..', '.', '.git', '__MACOSX', '.DS_Store'])
      data = {'name' => (name || path), 'type' => 'folder'}
      data[:children] = children = []
      Dir.foreach(path) do |entry|
        next if exclude.include?(entry)
        full_path = File.join(path, entry)
        if File.directory?(full_path)
          children << directory_hash(full_path, entry)
        else
          true_path = full_path.partition("app/assets/images/")[2]
          puts true_path
          link = ActionController::Base.helpers.image_path(true_path)
          children <<  "<li><a href='#{link}'>#{entry}</a></li>"
        end
      end
      return data
    end
    @string=""
    def listifier(hash)
      hash.each do |folder|
        if folder.is_a?(Hash)
          # puts folder[:children].length
          next if folder[:children].length == 0
          # puts "testing"
          cap = folder["name"].upcase
          str = "<li class='show-drop'><a href='#'>#{cap}</a><ul>"
          @string = @string + str
            # if kid[:children].length != 0
              # puts "length"
          listifier(folder[:children])
          @string = @string + "</ul>"
        else
          @string = @string + folder
        end

      end
    end

    # grab all files in subdirectory based on brand name
    puts @account
    @filenames = {"OUT OF HAND"=>["Adult Catalog", "Youth Catalog", "Comfort Colors", "New Specialty Program"]}
    # automate subfolders somehow
    @pdfs = directory_hash('app/assets/images'+ActionController::Base.helpers.asset_path(@account))
    @tester = listifier(@pdfs[:children])
    puts @string
  end

  def subfolder
    @account = params[:id]
    @subaccount = params[:subid]
    puts params
    @links = Dir.glob('app/assets/images'+ActionController::Base.helpers.asset_path(@account)+'/'+ActionController::Base.helpers.asset_path(@subaccount)+'/*')
    puts @links
    render "subfolder.html.erb"
  end

  def vendors
    render "vendors.html.erb"
  end

  def contact
    render "contact.html.erb"
  end

end
