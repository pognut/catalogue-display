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
    @pdfs = Dir.glob('public/assets/'+ActionController::Base.helpers.asset_path(@account)+'/*')
  end

end
