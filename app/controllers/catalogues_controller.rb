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
      Dir.entries(path).sort.each do |entry|
        # Dir.entries(path).each
        # puts entry
        next if exclude.include?(entry)
        full_path = File.join(path, entry)
        if File.directory?(full_path)
          if entry.include?("credit app")
            kids = Dir.entries(full_path)
            kids.reject! {|x|exclude.include?(x)}
            puts kids
            if kids.length >= 1
              # can add a kids.each loop here if mom ever wants more than one credit app
              child_path = File.join(full_path, kids[0])
              true_path = child_path.partition("app/assets/images/")[2]
              link = ActionController::Base.helpers.image_path(true_path)
              # puts full_path
              # puts link
              entry = entry.split('.')[0]
              if entry.include?('--')
                entry = entry.split('--')[1]
              end
              entry = entry.upcase

              children <<  "<li class='category'>CREDIT APP<li class='kid'><a href='#{link}'>#{entry}</a></li></li>"
            else
              # gotta fix these two somehow
              children <<  "<li><a href='#'>NO APP</a></li>"
            end
          else
            children << directory_hash(full_path, entry)
          end
        else
          true_path = full_path.partition("app/assets/images/")[2]
          link = ActionController::Base.helpers.image_path(true_path)
          puts true_path
          # puts link
          entry = entry.split('.')[0]
          if entry.include?('--')
            entry = entry.split('--')[1]
          end
          # this is where final kids are created
          children <<  "<li class='kid'><a href='#{link}'>#{entry}</a></li>"
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
          if cap.include?('--')
            clean = cap.split('--')[1]
            clean = clean.split('.')[0]
          else
            clean = cap.split('.')[0]
          end
          # this is where top level categories (catalogs etc) and categories with kids are created
          str = "<li class='category'>#{clean}"
          @string = @string + str
          listifier(folder[:children])
          # @string = @string + "</ul>"
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
    # puts @string
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

  def gallery
    render "gallery.html.erb"
  end

  def about
    render "about.html.erb"
  end

end
