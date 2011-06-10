require 'spec_helper'

def set_referer
  before :each do
    @request.env["HTTP_REFERER"] = root_url
  end
end

describe CollectionsController do
  login_admin

  context 'routes', :type => :routing do
    it { get('/collections').should be_routable }
    it { post('/collections').should be_routable }
    it { post('/collections/1/populate').should be_routable }
    it { post('/collections/1/depopulate').should be_routable }
    it { delete('/collections/1').should be_routable }
    it { put('/collections/1').should be_routable }
    it { get('/collections/1/show_build').should be_routable }
    it { post('/collections/1/build').should be_routable }

    it { get('/collections/1').should_not be_routable }
    it { get('/collections/new').should_not be_routable }
    it { get('/collections/1/edit').should_not be_routable }
  end

  context 'GET index' do
    it 'should render show' do
      get :index
      response.should render_template(:index)
    end

    it 'should assign @collections with all records' do
      collections = [Factory(:collection), Factory(:collection)]
      get :index
      assigns(:collections).should == collections
    end
  end

  context 'GET show_build' do
    before(:each) { @collection = Factory(:collection) }
    it 'should show the build page for a collection' do
      get :show_build, :id => @collection
      response.should render_template(:show_build)
    end

    it 'should provide the collection to the view' do
      get :show_build, :id => @collection
      assigns[:collection].should == @collection
    end
  end

  context 'POST build' do
  end

  context 'POST populate' do
    set_referer
    before :each do
      @collection = Factory(:collection)
      @video = Factory(:video)
    end

    it 'should add a video to the collection' do
      post :populate, :id => @collection.id, :video_id => @video.id
      @collection.reload.videos.should == [@video]
    end

    it 'should redirect to where we came from' do
      post :populate, :id => @collection.id, :video_id => @video.id
      response.should redirect_to(:back)
    end

    it 'should have a flash notice' do
      post :populate, :id => @collection.id, :video_id => @video.id
      flash.notice.should_not be_nil
    end
  end

  context 'POST depopulate' do
    set_referer
    before :each do
      @collection = Factory(:collection)
      @video = Factory(:video)
      @collection << @video
    end

    it 'should remove a video from the collection' do
      post :depopulate, :id => @collection.id, :video_id => @video.id
      @collection.reload.videos.should be_empty
    end

    it 'should redirect to where it came from' do
      post :depopulate, :id => @collection.id, :video_id => @video.id
      response.should redirect_to(:back)
    end

    it 'should have a flash notice' do
      post :depopulate, :id => @collection.id, :video_id => @video.id
      flash.notice.should_not be_nil
    end
  end

  context 'POST create' do
    set_referer
    before :each do
      @collection = Collection.new
      Collection.stub(:new => @collection)
    end

    context 'when validation passes' do
      before(:each) { @collection.stub(:valid? => true) }

      it 'should save the record' do
        post :create
        assigns(:collection).should_not be_new_record
      end

      it 'should assign the current user to the collection' do
        post :create
        assigns(:collection).user.should == @admin
      end

      it 'should redirect to the videos' do
        post :create
        response.should redirect_to(Video)
      end

      it 'should have a flash notice' do
        post :create
        flash[:notice].should_not be_nil
      end

      it 'should set the current collection to the one created' do
        post :create
        session[:cid].should == assigns(:collection).id
      end
    end
    
    context 'when validation fails' do
      before(:each) { @collection.stub(:valid? => false) }
      it 'should not save the record' do
        post :create
        assigns(:collection).should be_new_record
      end

      it 'redirect to where it came from' do
        post :create
        response.should redirect_to(:back)
      end

      it 'should have a flash alert' do
        post :create
        flash.alert.should_not be_nil
      end

      it 'should not change the current collection' do
        post :create
        session[:cid].should be_nil
      end
    end
  end

  context 'DELETE destroy' do
    before :each do
      @collection = Factory(:collection)
    end

    it 'should destroy the collection' do
      delete :destroy, :id => @collection.id
      Collection.find_by_id(@collection.id).should be_nil
    end

    it 'should have a flash notice' do
      delete :destroy, :id => @collection.id
      flash[:notice].should_not be_nil
    end

    it 'should redirect to the index' do
      delete :destroy, :id => @collection.id
      response.should redirect_to(Collection)
    end
  end
end
