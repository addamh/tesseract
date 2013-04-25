class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :signin, :signup, :newaccount, :failure]
  protect_from_forgery :except => :create     

  # GET all authentication services assigned to the current user
  def index
    @services = current_user.services.order('provider asc')
  end

  # POST to remove an authentication service
  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    
    if session[:service_id] == @service.id
      flash[:error] = 'You are currently signed in with this account!'
    else
      @service.destroy
    end
    
    redirect_to services_path
  end

  # POST from signup view
  def newaccount
    if params[:commit] == "Cancel"
      session[:authhash] = nil
      session.delete :authhash
      redirect_to root_url
    else  # create account
      @newuser = User.new
      # @newuser.profile = Profile.new
      @newuser.name = session[:authhash][:name]
      @newuser.email = session[:authhash][:email]
      @newuser.username = session[:authhash][:username]
      @newuser.last_seen = Time.now
      @newuser.credentials.build
      @newuser.credentials.build
      @newuser.credentials.build      
      @newuser.services.build(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email], :avatar_url => session[:authhash][:avatar_url])
      
      
      if @newuser.save!
        # signin existing user
        # in the session his user id and the service id used for signing in is stored
        session[:user_id] = @newuser.id
        session[:service_id] = @newuser.services.first.id
        
        @newuser.current_avatar = session[:service_id]
        @newuser.save!
        
        flash[:notice] = 'Your account has been created and you have been signed in!'
        redirect_to edit_user_path(@newuser.id)
      else
        flash[:error] = 'This is embarrassing! There was an error while creating your account from which we were not able to recover.'
        redirect_to root_url
      end  
    end
  end  
  
  # Sign out current user
  def signout 
    if current_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      flash[:notice] = 'You have been signed out!'
    end  
    redirect_to root_url
  end
  
  # callback: success
  # This handles signing in and adding an authentication service to existing accounts itself
  # It renders a separate view if there is a new user to create
  def create
    # get the service parameter from the Rails router
    params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']
    #raise omniauth.to_yaml
    # continue only if hash and parameter exist
    if omniauth and params[:service]

      # map the returned hashes to our variables first - the hashes differs for every service
      
      # create a new hash
      @authhash = Hash.new

      if service_route == 'facebook'
        omniauth['extra']['raw_info']['email'] ? @authhash[:email] =  omniauth['extra']['raw_info']['email'] : @authhash[:email] = ''
        omniauth['extra']['raw_info']['name'] ? @authhash[:name] =  omniauth['extra']['raw_info']['name'] : @authhash[:name] = ''
        omniauth['extra']['raw_info']['id'] ?  @authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : @authhash[:uid] = ''
        omniauth['info']['image'] ? @authhash[:avatar_url] = omniauth['info']['image'] : @authhash[:avatar_url] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
        omniauth['info']['nickname'] ? @authhash[:username] = omniauth['info']['nickname'] : @authhash[:username] = ''
      elsif service_route == 'github'
        omniauth['info']['email'] ? @authhash[:email] =  omniauth['info']['email'] : @authhash[:email] = ''
        omniauth['info']['name'] ? @authhash[:name] =  omniauth['info']['name'] : @authhash[:name] = ''
        omniauth['extra']['raw_info']['id'] ? @authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : @authhash[:uid] = ''
        omniauth['extra']['raw_info']['avatar_url'] ? @authhash[:avatar_url] = omniauth['extra']['raw_info']['avatar_url'] : @authhash[:avatar_url] = ''
        omniauth['provider'] ? @authhash[:provider] =  omniauth['provider'] : @authhash[:provider] = ''  
        omniauth['info']['nickname'] ? @authhash[:username] = omniauth['info']['nickname'] : @authhash[:username] = ''
      elsif ['google', 'google_apps', 'yahoo', 'twitter', 'myopenid', 'open_id', 'linkedin'].index(service_route) != nil
        omniauth['info']['nickname'] ? @authhash[:username] = omniauth['info']['nickname'] : @authhash[:username] = ''
        omniauth['info']['email'] ? @authhash[:email] =  omniauth['info']['email'] : @authhash[:email] = ''
        omniauth['info']['name'] ? @authhash[:name] =  omniauth['info']['name'] : @authhash[:name] = ''
        omniauth['info']['image'] ? @authhash[:avatar_url] = omniauth['info']['image'] : @authhash[:avatar_url] = ''
        omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      else        
        # debug to output the hash that has been returned when adding new services
        render :text => omniauth.to_yaml
        return
      end 
      
      if @authhash[:uid] != '' and @authhash[:provider] != ''
        
        auth = Service.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])

        # if the user is currently signed in, he/she might want to add another account to signin
        if user_signed_in?
          if auth
            flash[:notice] = 'Your account at ' + @authhash[:provider].capitalize + ' is already connected with this site.'
            redirect_to services_path
          else
            puts @authhash[:avatar_url]
            current_user.services.create!(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email], :avatar_url => @authhash[:avatar_url])
            flash[:notice] = 'Your ' + @authhash[:provider].capitalize + ' account has been added for signing in at this site.'
            redirect_to services_path
          end
        else
          if auth
            # signin existing user
            # in the session his user id and the service id used for signing in is stored
            session[:user_id] = auth.user.id
            session[:service_id] = auth.id
            flash[:notice] = 'Signed in successfully via ' + @authhash[:provider].capitalize + '.'
            current_user.last_seen = Time.now
            current_user.save!
            redirect_to root_url
          else
            # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
            session[:authhash] = @authhash
            render signup_services_path
          end
        end
      else
        flash[:error] =  'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. The service returned invalid data for the user id.'
        redirect_to signin_path
      end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '. The service did not return valid data.'
      redirect_to signin_path
    end
  end
  
  # callback: failure
  def failure
    flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
    redirect_to root_url
  end
end