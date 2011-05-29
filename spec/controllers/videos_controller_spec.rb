require 'spec_helper'

describe VideosController do
  let!(:video) { Factory(:video) }

  context 'GET index' do
    it 'assigns @videos' do
      get :index
      assigns(:videos).should == [video]
    end

    it 'renders the index template' do
      get :index
      response.should render_template(:index)
    end

    context 'with search params' do
      it 'should call search with the right params' do
        Video.should_receive(:search).with({'category_id' => '1', 'keywords' => 'One'})
        get :index, 'category_id' => '1', 'keywords' => 'One'
      end
    end
  end

  context 'GET show' do
    it 'assigns @video' do
      get :show, :id => video
      assigns(:video).should eq(video)
    end

    it 'renders the show template' do
      get :show, :id => video
      response.should render_template(:show)
    end

    it 'renders 404 when a video does not exist' do
      get :show, :id => (video.id + 1)
      response.code.should eq("404")
    end
  end

  context 'GET new' do
  	it 'assigns @video' do
  		get :new
  		assigns(:video).should be_new_record
  	end
    
    it 'renders the new template' do
      get :new
      response.should render_template(:new)
    end
  end
  
  context 'POST create' do
		before :each do
			@video = Video.new
			Video.stub(:new).and_return(@video)
		end
		
		context 'when validations pass' do
			before :each do
				@video.stub(:save => true)
			end
			
			it 'should redirect to show' do
				post :create
				response.should redirect_to(@video)
			end
			
			it 'should have a flash notice' do
				post :create
				flash[:notice].should_not be_nil
			end
		end
		
		context 'when validations fail' do
			before :each do
				@video.stub(:save => false)
			end
			
			it 'should render new' do
				post :create
				response.should render_template("new")
			end
			
			it 'should not have a flash notice' do
				post :create
				flash[:notice].should be_nil
			end
		end
  end
  
  context 'GET edit' do
  	before :each do
  		@video = Factory(:video)
  	end
  	
		it 'assigns @video' do
			get :edit, :id => @video.id
			assigns(:video).should == @video
		end
    
    it 'renders the edit template' do
      get :edit, :id => @video.id
      response.should render_template(:edit)
    end
  end
  
  context 'PUT update' do
  	before :each do
  		@video = Factory(:video)
  		Video.stub(:find => @video)
  	end
  	
  	context 'when validations pass' do
  		before :each do
  			@video.stub(:update_attributes => true)
  		end
  		
  		it 'should redirect to show' do
  			put :update, :id => @video.id
  			response.should redirect_to(@video)
  		end
  		
  		it 'should have a flash notice' do
  			put :update, :id => @video.id
  			flash[:notice].should_not be_nil
  		end
  	end
  	
  	context 'when validations fail' do
  		before :each do
  			@video.stub(:update_attributes => false)
  		end
  		
  		it 'should render edit' do
  			put :update, :id => @video.id
  			response.should render_template(:edit)
  		end
  		
  		it 'should not have a flash notice' do
  			put :update, :id => @video.id
  			flash[:notice].should be_nil
  		end
  	end
  	
  end
  
  context 'DELETE destroy' do
  	before :each do
  		@video = Factory(:video)
  		Video.stub(:find => @video)
  	end
  	
  	it 'should redirect to index' do
  		delete :destroy, :id => @video.id 
  		response.should redirect_to(Video)
  	end
  	
  	it 'should have a flash notice' do
  		delete :destroy, :id => @video.id
  		flash[:notice].should_not be_nil
  	end
  	
  	it 'should destroy the video' do
  		@video.should_receive :destroy
  		delete :destroy, :id => @video.id
  	end
  end
  
end
