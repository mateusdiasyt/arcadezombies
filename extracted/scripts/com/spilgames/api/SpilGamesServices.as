package com.spilgames.api
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Security;
   import flash.utils.getTimer;
   
   [Event(type="servicesFailed",name="flash.events.ErrorEvent")]
   [Event(type="servicesReady",name="flash.events.Event")]
   public class SpilGamesServices extends MovieClip
   {
      
      public static const INVALID_ID:int = -1;
      
      public static const INVALID_DOMAIN:String = "invalidDomain";
      
      public static const CONFIGURATION_FAILED:String = "configurationFailure";
      
      private static var _instance:SpilGamesServices = null;
      
      private static const MAX_CONNECTION_LOAD_RETRIES:uint = 99;
      
      private const DEFAULT_CONNECTION_LOCATION:String = "http://www8.agame.com/games/flash/services/ServicesConnection.swf";
      
      private var _servicesConnection:* = null;
      
      private var _loader:Loader;
      
      private var _connecting:Boolean = false;
      
      private var _connected:Boolean = false;
      
      private var _request:URLRequest;
      
      private var _numConnectionLoadTries:uint = 0;
      
      private var _alwaysInFront:Boolean = false;
      
      private var currentDelay:Number = 0;
      
      private var previousFrameTime:Number;
      
      public function SpilGamesServices(access:Private = null)
      {
         super();
         if(!access)
         {
            throw new Error("Cannot instantiate this class, use SpilGamesServices.getInstance");
         }
      }
      
      public static function getInstance() : SpilGamesServices
      {
         if(!_instance)
         {
            _instance = new SpilGamesServices(new Private());
         }
         return _instance;
      }
      
      public function get version() : String
      {
         return "1.1";
      }
      
      public function get connecting() : Boolean
      {
         return this._connecting;
      }
      
      public function get connection() : *
      {
         return this._servicesConnection;
      }
      
      public function set alwaysInFront(value:Boolean) : void
      {
         if(this._alwaysInFront != value)
         {
            this._alwaysInFront = value;
            if(this._alwaysInFront)
            {
               addEventListener(Event.ENTER_FRAME,this.bringToFront);
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.bringToFront);
            }
         }
      }
      
      public function get alwaysInFront() : Boolean
      {
         return this._alwaysInFront;
      }
      
      public function connect(clip:DisplayObjectContainer, ... rest) : void
      {
         var connectionLocation:String = null;
         var urlVariables:URLVariables = null;
         var date:Date = null;
         if(!this._connecting && !this._connected)
         {
            if(!clip.stage)
            {
               throw new Error("The given clip must be present in the display list (added to stage)");
            }
            this._connecting = true;
            clip.stage.addChild(this);
            addEventListener(Event.REMOVED_FROM_STAGE,this.handleRemovedFromStage);
            if(Boolean(root.loaderInfo.parameters["servicesLoc"]) && root.loaderInfo.parameters["servicesLoc"].length > 0)
            {
               connectionLocation = root.loaderInfo.parameters["servicesLoc"];
               this._request = new URLRequest(connectionLocation);
            }
            else
            {
               connectionLocation = this.DEFAULT_CONNECTION_LOCATION;
               urlVariables = new URLVariables();
               date = new Date();
               urlVariables.nocache = (date.fullYear * 12 + (date.month + 1)) * 31 + date.day;
               this._request = new URLRequest(connectionLocation);
               this._request.data = urlVariables;
            }
            this.allowDomain(connectionLocation);
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.handleLoadComplete);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleIOError);
            this._loader.load(this._request);
         }
      }
      
      public function disconnect() : void
      {
         if(this._servicesConnection)
         {
            this._servicesConnection.removeEventListener(Event.COMPLETE,this.handleServicesReady);
            this._servicesConnection.removeEventListener(ErrorEvent.ERROR,this.handleServicesFailed);
            this._servicesConnection.removeEventListener("serviceError",this.handleServiceError);
            if(this._connected)
            {
               this._servicesConnection.disconnect();
            }
            removeChild(this._servicesConnection);
         }
         this._servicesConnection = null;
         if(Boolean(this._loader))
         {
            try
            {
               this._loader.close();
            }
            catch(e:Error)
            {
            }
            finally
            {
               this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.handleLoadComplete);
               this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIOError);
            }
            this._loader = null;
         }
         removeEventListener(Event.ENTER_FRAME,this.bringToFront);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.handleRemovedFromStage);
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         this._connected = this._connecting = false;
      }
      
      public function getChannelID() : int
      {
         if(this._servicesConnection != null)
         {
            return this._servicesConnection.getChannelID();
         }
         return INVALID_ID;
      }
      
      public function getSiteID() : int
      {
         if(this._servicesConnection != null)
         {
            return this._servicesConnection.getSiteID();
         }
         return INVALID_ID;
      }
      
      public function getItemID() : int
      {
         if(this._servicesConnection != null)
         {
            return this._servicesConnection.getItemID();
         }
         return INVALID_ID;
      }
      
      public function isReady() : Boolean
      {
         return this._servicesConnection != null && Boolean(this._servicesConnection.isReady());
      }
      
      public function isDomainAllowed() : Boolean
      {
         return this._servicesConnection != null && Boolean(this._servicesConnection.isDomainValid());
      }
      
      public function isServiceAvailable(serviceID:String) : Boolean
      {
         return this.isReady() && Boolean(this._servicesConnection.isServiceAvailable(serviceID));
      }
      
      public function send(serviceID:String, functionName:String, callback:Function, args:Object = null) : int
      {
         if(this.isReady())
         {
            return this._servicesConnection.send(serviceID,functionName,callback,args);
         }
         return INVALID_ID;
      }
      
      public function bringToFront(e:Event = null) : void
      {
         if(Boolean(parent))
         {
            try
            {
               parent.setChildIndex(this,parent.numChildren - 1);
            }
            catch(e:Error)
            {
               removeEventListener(Event.ENTER_FRAME,bringToFront);
            }
         }
      }
      
      public function allowDomain(domain:String) : void
      {
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
      }
      
      private function handleRemovedFromStage(e:Event) : void
      {
         trace("WARNING: please do not remove SpilGamesServices from the stage");
      }
      
      private function handleLoadComplete(e:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.handleLoadComplete);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIOError);
         this._servicesConnection = LoaderInfo(e.target).content;
         this._servicesConnection.addEventListener(Event.COMPLETE,this.handleServicesReady);
         this._servicesConnection.addEventListener(ErrorEvent.ERROR,this.handleServicesFailed);
         this._servicesConnection.addEventListener("serviceError",this.handleServiceError);
         addChild(this._servicesConnection);
      }
      
      private function handleIOError(e:IOErrorEvent) : void
      {
         ++this._numConnectionLoadTries;
         if(this._numConnectionLoadTries > MAX_CONNECTION_LOAD_RETRIES)
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.handleLoadComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIOError);
            this._connecting = false;
            trace("ERROR: SpilGamesServices failed to load the connection object");
            if(hasEventListener(e.type))
            {
               dispatchEvent(e);
            }
         }
         else
         {
            trace("WARN: SpilGamesServices failed to load the connection object, retry #" + this._numConnectionLoadTries);
            this.previousFrameTime = getTimer();
            addEventListener(Event.ENTER_FRAME,this.updateConnectionRetry);
         }
      }
      
      private function updateConnectionRetry(e:Event) : void
      {
         var currentFrameTime:Number = getTimer();
         var deltaTime:Number = (currentFrameTime - this.previousFrameTime) / 1000;
         this.currentDelay += deltaTime;
         if(this.currentDelay >= 2)
         {
            trace("WARN: SpilGamesServices trying to reconnect after: " + this.currentDelay);
            this._loader.load(this._request);
            removeEventListener(Event.ENTER_FRAME,this.updateConnectionRetry);
            this.currentDelay = 0;
         }
         this.previousFrameTime = currentFrameTime;
      }
      
      private function handleServicesReady(e:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.handleLoadComplete);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIOError);
         this._connected = true;
         this._connecting = false;
         dispatchEvent(new Event("servicesReady"));
      }
      
      private function handleServicesFailed(e:ErrorEvent) : void
      {
         this._servicesConnection.addEventListener(Event.COMPLETE,this.handleServicesReady);
         this._servicesConnection.addEventListener(ErrorEvent.ERROR,this.handleServicesFailed);
         this._servicesConnection.addEventListener("serviceError",this.handleServiceError);
         this._connecting = false;
         if(hasEventListener("servicesFailed"))
         {
            dispatchEvent(new ErrorEvent("servicesFailed",false,false,e.text));
         }
      }
      
      private function handleServiceError(e:Event) : void
      {
         var message:String = null;
         if(hasEventListener("serviceError"))
         {
            message = "";
            if(e is ErrorEvent)
            {
               message = ErrorEvent(e).text;
            }
            else
            {
               message = e.toString();
            }
            dispatchEvent(new ErrorEvent("serviceError",false,false,message));
         }
      }
   }
}

class Private
{
   
   public function Private()
   {
      super();
   }
}
