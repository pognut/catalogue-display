class CataloguesController < ApplicationController
  def index
  end

  def pdf
    # pdf_filename = File.join(Rails.root, "app/assets/images/spirit sp 17catalog.pdf")
    # send_file(pdf_filename, :filename => "spirit sp 17catalog.pdf", :disposition => 'inline', :type => "application/pdf")
  end

end
