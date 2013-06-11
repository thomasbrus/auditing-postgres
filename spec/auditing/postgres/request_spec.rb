require 'spec_helper'

describe "with respect to auditing requests" do

  it "should correctly initialize" do
  end

  it "should have a timestamp attribute" do
  end

  it "should add a timestamp value after creation" do
  end

  it "should correctly replace Date params with Times" do
  end

  it "should correctly replace DateTime params with Time's" do
  end

  context "with respect to saving" do
    it "should correctly save the request" do
    end
  end

  describe "with respect to retrieval" do
    it "should correctly retrieve a request by its _id" do      
    end

    it "should correctly retrieve requests on a certain day" do      
    end

    it "should correctly retrieve requests by url" do
    end

    it "should correctly retrieve requests by part of an url" do
    end

    it "should correctly retrieve requests by user_id" do
    end

    it "should correctly retrieve requests by real_user_id" do
    end

    it "should correctly retrieve requests by method" do      
    end

    describe "with respect to modifications" do
      it "should correctly retrieve the corresponding modifications" do
      end

      it "should correctly retrieve the same request through the modifications" do
      end
    end

  end

  describe "with respect to urls" do
    it "should create url parts when saved" do      
    end

    it "should create correct url parts" do    
    end

    it "should correctly get weeks" do
    end

    it "should correctly retrieve requests based on parts of the url" do
    end

    it "should be possible to add extra query parts to the url_parts query" do
    end
  end
end
