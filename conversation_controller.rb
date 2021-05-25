class ConversationController < ApplicationController
  def index
    @@cvst=Conversation.new
    @@pgrs=Progress.new
    @que="わたし："+@@cvst.get
    @@pgrs.put @que
    @pgs=@@pgrs.get
  end
  def next
    if (ans=params[:answer])!=""
      @@cvst.put ans
      @@pgrs.put "あなた："+ans
    end
    @que="わたし："+@@cvst.get
    @@pgrs.put @que if ans!=""
    @pgs=@@pgrs.get
    render("/conversation/index")
  end
end

class Progress
  def initialize
    @@pgs=[]
  end
  def put dat
    @@pgs.push dat
    if @@pgs.size>38
      @@pgs.shift
    end
  end
  def get
    return @@pgs
  end
end

class Conversation
  @@data={"こんにちは"=>"こんにちは","ばいばい"=>"バイバイ！"}
  def initialize
    @@henji="こんにちは"
    @@newkey=nil
  end
  def put aite
    if @@newkey!=nil
  		@@data.store @@newkey,aite
  	end
    if @@data.has_key? aite
      @@henji=@@data[aite]
      @@newkey=nil
    else
      @@henji=aite+"？"
      @@newkey=aite
    end
  end
  def get
    return @@henji
  end
end
