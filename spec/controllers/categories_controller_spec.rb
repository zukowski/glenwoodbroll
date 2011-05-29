require 'spec_helper'

describe CategoriesController do
  login_admin

  context 'routes', :type => :routing do
    it { get('/categories').should be_routable }
    it { get('/categories/new').should be_routable }
    it { get('/categories/1/edit').should be_routable }
    it { post('/categories').should be_routable }
    it { put('/categories/1').should be_routable }
    it { delete('/categories/1').should be_routable }
    
    it { get('/categories/1').should_not be_routable }
  end

  context 'GET index'do
    it 'should render index' do
      get :index
      response.should render_template(:index)
    end

    it 'should assign @categories with categories' do
      Factory(:category)
      get :index
      assigns(:categories).should_not be_empty
    end
  end

  context 'GET new' do
    it 'should render new' do
      get :new
      response.should render_template(:new)
    end

    it 'should assign @category with a new record' do
      get :new
      assigns(:category).should be_new_record
    end
  end

  context 'GET edit' do
    before(:each) { @category = Factory(:category) }
    it 'should render edit' do
      get :edit, :id => @category.id
      response.should render_template(:edit)
    end

    it 'assgin @category with the specified record' do
      get :edit, :id => @category.id
      assigns(:category).should == @category
    end
  end

  context 'POST create' do
    before :each do
      @category = Category.new
      Category.stub(:new => @category)
      @category.stub(:valid? => true)
    end

    context 'when validation passes' do
      before(:each) { @category.stub(:valid? => true) }

      it 'should persist the record' do
        post :create
        assigns(:category).should_not be_new_record
      end

      it 'should redirect to the index' do
        post :create
        response.should redirect_to(Category)
      end

      it 'should have a flash notice' do
        post :create
        flash[:notice].should_not be_nil
      end
    end

    context 'when validation fails' do
      before(:each) { @category.stub(:save => false) }

      it 'should not persist the record' do
        post :create
        assigns(:category).should be_new_record
      end

      it 'should render new' do
        post :create
        response.should render_template(:new)
      end
    end
  end

  context 'PUT update' do
    before :each do
      @category = Factory(:category)
      Category.stub(:find => @category)
      @category.stub(:update_attributes => true)
    end

    context 'when validation passes' do
      it 'should update the record' do
        @category.should_receive(:update_attributes).with({"the"=>"params"}).and_return(true)
        put :update, :id => @category.id, :category => {"the" => "params"}
      end

      it 'should redirect to the index' do
        put :update, :id => @category.id
        response.should redirect_to(Category)
      end

      it 'should have a flash notice' do
        put :update, :id => @category.id
        flash[:notice].should_not be_nil
      end
    end

    context 'when validation fails' do
      before(:each) { @category.stub(:update_attributes => false) }

      it 'should render edit' do
        put :update, :id => @category.id
        response.should render_template(:edit)
      end
    end
  end

  context 'DELETE destroy' do
    before(:each) { @category = Factory(:category) }
    it 'should redirect to the index' do
      delete :destroy, :id => @category.id
      response.should redirect_to(Category)
    end

    it 'should have a flash notice' do
      delete :destroy, :id => @category.id
      flash[:notice].should_not be_nil
    end

    it 'should destroy the record' do
      delete :destroy, :id => @category.id
      Category.find_by_id(@category.id).should be_nil
    end
  end
end
