require 'spec_helper'

describe VideoCollectionsController do
  login_admin

  context 'GET index' do
    it 'should render show' do
      get :index
      response.should render_template(:index)
    end

    it 'should assign @video_collections with all records' do
      collections = [Factory(:video_collection), Factory(:video_collection)]
      get :index
      assigns(:video_collections).should == collections
    end
  end

  context 'GET show' do
    before :each do
      @collection = Factory(:video_collection)
    end

    it 'should render show' do
      get :show, :id => @collection.id
      response.should render_template(:show)
    end

    it 'should assign @video with the selected record' do
      get :show, :id => @collection.id
      assigns(:video_collection).should == @collection
    end
  end

  context 'POST create' do
    before :each do
      @video_collection = VideoCollection.new
      VideoCollection.stub(:new => @video_collection)
    end

    context 'when validation passes' do
      before(:each) { @video_collection.stub(:valid? => true) }

      it 'should save the record' do
        post :create
        assigns(:video_collection).should_not be_new_record
      end

      it 'should assign the current user to the collection' do
        post :create
        assigns(:video_collection).user.should == @admin
      end

      it 'should redirect to the videos' do
        post :create
        response.should redirect_to(Video)
      end

      it 'should have a flash notice' do
        post :create
        flash[:notice].should_not be_nil
      end

      it 'should set the current collection to the one created'
    end
    
    context 'when validation fails' do
      before(:each) { @video_collection.stub(:valid? => false) }
      it 'should not save the record' do
        post :create
        assigns(:video_collection).should be_new_record
      end

      it 'should render new' do
        post :create
        response.should redirect_to(VideoCollection)
      end

      it 'should have a flash error' do
        post :create
        flash[:error].should_not be_nil
      end

      it 'should not change the current collection'
    end
  end

  context 'DELETE destroy' do
    before :each do
      @collection = Factory(:video_collection)
    end

    it 'should destroy the collection' do
      delete :destroy, :id => @collection.id
      VideoCollection.find_by_id(@collection.id).should be_nil
    end

    it 'should have a flash notice' do
      delete :destroy, :id => @collection.id
      flash[:notice].should_not be_nil
    end

    it 'should redirect to the index' do
      delete :destroy, :id => @collection.id
      response.should redirect_to(VideoCollection)
    end
  end
end
