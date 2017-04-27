class CataloguesController < ApplicationController
  def index
  end

  def pdf
    # pdf_filename = File.join(Rails.root, "app/assets/images/spirit sp 17catalog.pdf")
    # send_file(pdf_filename, :filename => "spirit sp 17catalog.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def show
    # get brand name from URL (Don't ever do this in RL)
    @account = params[:id]
    # grab all files in subdirectory based on brand name
    puts @account
    @filenames = {"OUT OF HAND"=>["Adult Catalog", "Youth Catalog", "Comfort Colors", "New Specialty Program"]}
    # automate subfolders somehow
    @pdfs = Dir.glob('app/assets/images'+ActionController::Base.helpers.asset_path(@account)+'/*')
  end

  def subfolder
    @account = params[:id]
    @subaccount = params[:subid]
    puts params
    @links = Dir.glob('app/assets/images'+ActionController::Base.helpers.asset_path(@account)+'/'+ActionController::Base.helpers.asset_path(@subaccount)+'/*')
    puts @links
    render "subfolder.html.erb"
  end

  def contact
    render "contact.html.erb"
  end

end
