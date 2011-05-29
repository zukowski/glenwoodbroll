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
end
