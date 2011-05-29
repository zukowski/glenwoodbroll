require 'spec_helper'

describe CollectionsController do
  login_admin

  context 'routes', :type => :routing do
    it { get('/collections').should be_routable }
    it { post('/collections').should be_routable }
    it { delete('/collections/1').should be_routable }

    it { get('/collections/1').should_not be_routable }
    it { get('/collections/new').should_not be_routable }
    it { get('/collections/1/edit').should_not be_routable }
    it { put('/collections/1').should_not be_routable }
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

  context 'POST create' do
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

      it 'should set the current collection to the one created'
    end
    
    context 'when validation fails' do
      before(:each) { @collection.stub(:valid? => false) }
      it 'should not save the record' do
        post :create
        assigns(:collection).should be_new_record
      end

      it 'should render new' do
        post :create
        response.should redirect_to(Collection)
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
