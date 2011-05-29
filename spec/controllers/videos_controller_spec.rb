require 'spec_helper'

describe VideosController do
  login_admin

  let(:search_params) { {'category_id' => '1', 'keywords' => 'One'} }

  context 'routes', :type => :routing do
    it { get('/videos').should be_routable }
    it { get('/videos/1').should be_routable }
    it { get('/videos/new').should be_routable }
    it { get('/videos/1/edit').should be_routable }
    it { post('/videos').should be_routable }
    it { put('/videos/1').should be_routable }
    it { delete('/videos/1').should be_routable }
  end
  
  context 'GET index' do
    it 'assigns @videos' do
      @video = Factory(:video)
      get :index
      assigns(:videos).should == [@video]
    end

    it 'renders the index template' do
      get :index
      response.should render_template(:index)
    end

    context 'with search params' do
      it 'should call search with the right params' do
        Video.should_receive(:search).with(search_params)
        get :index, search_params
      end

      it 'should not ignore extraneous params' do
        Video.should_receive(:search).with(search_params)
        get :index, search_params.merge('bad'=>'param')
      end
    end
  end

  context 'GET show' do
    before(:each) { @video = Factory(:video) }
    it 'assigns @video with the selected video' do
      get :show, :id => @video.id
      assigns(:video).should == @video
    end

    it 'renders the show template' do
      get :show, :id => @video.id
      response.should render_template(:show)
    end
  end

  context 'GET new' do
  	it 'assigns @video' do
      get :new
      assigns(:video).should be_a_new(Video)
  	end
    
    it 'renders the new template' do
      get :new
      response.should render_template(:new)
    end
  end
  
  context 'POST create' do
    before :each do
      @video = Video.new
      Video.stub(:new => @video)
    end
		
    context 'when validations pass' do
      before(:each) { @video.stub(:valid? => true) }

      it 'should save the record' do
        post :create
        @video.should_not be_new_record
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
      before(:each) { @video.stub(:valid? => false) }
      
      it 'should render new' do
        post :create
        response.should render_template("new")
      end
    end
  end
  
  context 'GET edit' do
  	before(:each) { @video = Factory(:video) }
  	
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
      before(:each) { @video.stub(:valid? => true) }
      
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
      before(:each) { @video.stub(:valid? => false) }
      
      it 'should render edit' do
        put :update, :id => @video.id
        response.should render_template(:edit)
      end
  	end
  end
  
  context 'DELETE destroy' do
  	before(:each) { @video = Factory(:video) }
  	
  	it 'should redirect to index' do
      delete :destroy, :id => @video.id 
      response.should redirect_to(Video)
  	end
  	
  	it 'should have a flash notice' do
      delete :destroy, :id => @video.id
      flash[:notice].should_not be_nil
  	end
  	
  	it 'should destroy the video' do
      delete :destroy, :id => @video.id
      Video.find_by_id(@video.id).should be_nil
  	end
  end
end
