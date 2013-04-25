class CredentialsController < ApplicationController
  def update
    @credential = Credential.find(params[:id])
    @credential.update_attributes(params[:credential])
  end
  
  def destroy
    @credential = Credential.find(params[:id])
    @credential.title = nil;
    @credential.location = nil;
    @credential.achieved = nil;
    @credential.save
  end
end
