require 'spec_helper.rb'

module AuditingRequestSpecHelper
  def compare_requests(stored_request, retrieved_request)
    stored_request.reload

    retrieved_request.url == stored_request.url
    retrieved_request.method == stored_request.method
    retrieved_request.user_id == stored_request.user_id
    retrieved_request.real_user_id == stored_request.real_user_id
    retrieved_request.at == stored_request.at
  end

  def compare_modifications(stored_mods, retrieved_mods)
    stored_mods.reload

    retrieved_mods.id.should == stored_mods.id
    retrieved_mods.request_id.should == (stored_mods.request_id ? stored_mods.request_id : "")
    retrieved_mods.object_type.should == stored_mods.object_type
    retrieved_mods.object_id.should == stored_mods.object_id
    
    retrieved_mods.object_changes.each do |key, value|
      stored_mods.object_changes[key].should == value
    end
    
    retrieved_mods.action.should == stored_mods.action
    retrieved_mods.at.should == stored_mods.at.to_time
  end
end

describe "with respect to auditing requests" do
  include AuditingRequestSpecHelper

  before :each do
    clean_sheet
  end

  it "should correctly initialize" do
    options = {
      :url => 'http://test.com',
      :method => 'get',
      :params => {:test_param1 => '1', :test_param2 => '2'},
      :user_id => 3,
      :real_user_id => 5,
      :at => Time.now
    }

    request = Auditing::Postgres::Request.new(options)
    options.each do |key, value|
      ret_val = request.send(key)
      if value.is_a?(Hash)
        value.each do |k, v|
          ret_val[k.to_sym].should == v
        end
      else
        ret_val.should == value
      end
    end
  end

  # it "should have a timestamp attribute" do
  #   Auditing::Postgres::Request.timestamped_attribute.should_not be_nil
  # end

  it "should add a timestamp value after creation" do
    options = {
      :params => {:first => Date.today}
    }
    request = Auditing::Postgres::Request.create(options)
    request.reload
    request.timestamp.should_not be_nil
    # Remove this?
    # request.timestamp.should_not == BSON::Timestamp.new(0,0)
  end

  context "with respect to saving" do
    it "should correctly save the request" do
      options = {
        :url => 'http://test.com',
        :method => 'get',
        :params => {:test_param1 => '1', :test_param2 => '2'},
        :user_id => 3,
        :real_user_id => 5,
        :at => Time.now
      }
      request = Auditing::Postgres::Request.new(options)
      request.save.should be_true
      request.id.should_not be_nil

      Auditing::Postgres::Request.count.should == 1

      other_request = request.class.find(request.id)

      compare_requests(request, other_request)
    end
  end

  describe "with respect to retrieval" do
    before(:each) do
      @request_time = DateTime.now.to_time
      options = {
        :url => 'http://test.com',
        :method => 'get',
        :params => {:test_param1 => '1', :test_param2 => '2'},
        :user_id => 3,
        :real_user_id => 5,
        :at => @request_time
      }
      @request = Auditing::Postgres::Request.new(options)
      @request.save.should be_true
      Auditing::Postgres::Request.find(@request.id).should_not be_nil
    end

    it "should correctly retrieve a request by its _id" do
      req = Auditing::Postgres::Request.find_by_id(@request.id)
      compare_requests(@request, req)
    end

    it "should correctly retrieve requests on a certain day" do
      reqs = Auditing::Postgres::Request.find_by_day(Date.today)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)

      reqs = Auditing::Postgres::Request.find_by_day(DateTime.now)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)
    end

    it "should correctly retrieve requests by url" do
      reqs = Auditing::Postgres::Request.find_by_url(@request.url)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)
    end

    it "should correctly retrieve requests by part of an url" do
      reqs = Auditing::Postgres::Request.find_by_url(@request.url[0, @request.url.length - 2], true)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)
    end

    it "should correctly retrieve requests by user_id" do
      reqs = Auditing::Postgres::Request.find_by_user(@request.user_id)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)
    end

    it "should correctly retrieve requests by real_user_id" do
      reqs = Auditing::Postgres::Request.find_by_real_user_id(@request.real_user_id)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)
    end

    it "should correctly retrieve requests by method" do
      reqs = Auditing::Postgres::Request.find_by_method(@request.method)
      reqs.size.should == 1
      compare_requests(@request, reqs.first)
    end

    describe "with respect to modifications" do
      before :each do
        options = {
          :request_id => @request.id,
          :object_type => "Audited::Request",
          :object_id => @request.id.to_s,
          :object_changes => {:url => [@request.url, "#{@request.url}/request"]},
          :action => 'get',
          :at => @request_time
        }
        @modification = Auditing::Postgres::Modification.new(options)
        @modification.save.should be_true
        @modification.id.should_not be_nil
        Auditing::Postgres::Modification.count == 1
      end

      it "should correctly retrieve the corresponding modifications" do
        @request.modifications.should_not be_nil
        @request.modifications.size.should == 1
        compare_modifications(@modification, @request.modifications.first)
      end

      it "should correctly retrieve the same request through the modifications" do
        @request.modifications.should_not be_nil
        @request.modifications.size.should == 1
        compare_modifications(@modification, @request.modifications.first)
        compare_requests(@request, @request.modifications.first.request)
      end
    end
  end
end
