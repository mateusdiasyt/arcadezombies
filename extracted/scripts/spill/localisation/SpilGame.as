package spill.localisation
{
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   use namespace spil_internal;
   
   [Event(name="brandingChanged",type="spill.localisation.SpilGame.BRANDING_CHANGED")]
   [Event(name="languageChanged",type="spill.localisation.SpilGame.LANGUAGE_CHANGED")]
   public class SpilGame
   {
      
      spil_internal static var gameName:String;
      
      public static var currentBranding:Brand;
      
      public static var currentLanguage:Language;
      
      spil_internal static var emailPage:String;
      
      spil_internal static var portalGroup:uint;
      
      private static var eventDispatcher:EventDispatcher;
      
      private static var contexMenuItem:ContextMenuItem;
      
      private static var stage:Sprite;
      
      private static var channelLock:Boolean = false;
      
      private static var _init:Boolean = false;
      
      private static var localDomains:Object = new Object();
      
      private static var strings:Object = new Object();
      
      private static const cookiePath:String = "/";
      
      private static const cookieName:String = "spilgames_language_v100";
      
      private static const cookieLanguageVar:String = "savedLang";
      
      spil_internal static var debugHostDomain:String = "";
      
      spil_internal static var debugEmbedDomain:String = "";
      
      public static const LANGUAGE_CHANGED:String = "languageChanged";
      
      public static const BRANDING_CHANGED:String = "brandingChanged";
      
      public function SpilGame()
      {
         super();
      }
      
      public static function initialize(param1:String, param2:int, param3:String, param4:Sprite, param5:Boolean = false) : void
      {
         stage = param4;
         if(_init)
         {
            trace("ERROR: LocalisationManager already initialised");
            return;
         }
         _init = true;
         localDomains["localhost"] = true;
         localDomains["www8.agame.com"] = true;
         localDomains["gamedev.dev.spilgames.com"] = true;
         localDomains["stg.spel.nl"] = true;
         localDomains["stg.girlsgogames.nl"] = true;
         localDomains["stg.pl.spel.nl"] = true;
         localDomains["stg.pl.girlsgogames.nl"] = true;
         trace(localDomains["stg.girlsgogames.nl"]);
         Brandings.initialize();
         Languages.initialize();
         initContexMenu(param4);
         channelLock = param5;
         gameName = param1.replace(" ","_");
         portalGroup = param2;
         emailPage = param3;
         chooseLanguage();
         chooseBranding();
         if(portalGroup == PortalGroup.HYVES)
         {
            changeLanguage("nl");
         }
      }
      
      public static function initTextField(param1:TextField) : void
      {
         var _loc2_:TextFormat = null;
         trace(param1.text);
         param1.text = param1.text.replace(/{([^{}]*)}/g,replaceFn);
         trace(param1.text);
         param1.embedFonts = currentLanguage.embedFonts;
         if(currentLanguage.forceFont != "")
         {
            _loc2_ = new TextFormat();
            _loc2_.font = currentLanguage.forceFont;
            param1.setTextFormat(_loc2_);
         }
      }
      
      private static function replaceFn() : String
      {
         var _loc2_:String = SpilGame.getString(arguments[1]);
         if(!_loc2_ || _loc2_ == "")
         {
            return "{" + arguments[1] + "}";
         }
         return _loc2_;
      }
      
      public static function outputAllBrands() : String
      {
         var _loc3_:Brand = null;
         var _loc1_:Array = Brandings.getBrandsArray();
         var _loc2_:String = "";
         for each(_loc3_ in _loc1_)
         {
            _loc2_ += _loc3_.getSendToFriendLink(gameName,emailPage,isExternal,embedDomain) + "\n";
         }
         return _loc2_;
      }
      
      public static function traceAllBrands() : void
      {
         trace(outputAllBrands());
      }
      
      public static function getMoreGamesLink(param1:String = "") : String
      {
         var _loc2_:String = Boolean(embedDomain) ? embedDomain : hostingDomain;
         return currentBranding.getMoreGamesLink(gameName,isExternal,_loc2_,param1);
      }
      
      public static function getSendToFriendLink() : String
      {
         return currentBranding.getSendToFriendLink(gameName,emailPage,isExternal,embedDomain);
      }
      
      public static function getPromotionLink(param1:String = "feature_promotion") : String
      {
         var _loc2_:String = Boolean(embedDomain) ? embedDomain : hostingDomain;
         return currentBranding.getPromotionLink(gameName,emailPage,isExternal,_loc2_,param1);
      }
      
      public static function getSpilCompanyLink() : String
      {
         var _loc1_:String = "http://www.gameportal.net/";
         _loc1_ += "?utm_medium=brandedgames_" + (isExternal ? "external" : "internal");
         _loc1_ += "&utm_campaign=" + gameName;
         _loc1_ += "&utm_source=" + Brand.stripSubDomain(Boolean(embedDomain) ? embedDomain : hostingDomain);
         return _loc1_ + "&utm_content=Branding_Link";
      }
      
      public static function importXML(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:Object = null;
         var _loc4_:XML = null;
         for each(_loc2_ in param1.children())
         {
            _loc3_ = strings[_loc2_.identifier] = new Object();
            for each(_loc4_ in _loc2_.children())
            {
               _loc3_[_loc4_.name()] = _loc4_.children()[0].toString();
            }
         }
      }
      
      public static function importXMLv2(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:Object = null;
         var _loc4_:XML = null;
         for each(_loc2_ in param1.children())
         {
            _loc3_ = strings[_loc2_.attribute("identifier")] = new Object();
            for each(_loc4_ in _loc2_.children())
            {
               if(_loc4_.children().length() > 0)
               {
                  _loc3_[_loc4_.name()] = _loc4_.children()[0].toString();
               }
               else
               {
                  _loc3_[_loc4_.name()] = "";
               }
            }
         }
      }
      
      public static function getString(param1:String) : String
      {
         var _loc2_:Object = strings[param1];
         if(Boolean(_loc2_))
         {
            if(Boolean(currentLanguage.textLanguage))
            {
               return _loc2_[currentLanguage.textLanguage];
            }
            if(Boolean(_loc2_[currentLanguage.name]))
            {
               return _loc2_[currentLanguage.name];
            }
            return _loc2_["en_us"];
         }
         return "";
      }
      
      private static function initContexMenu(param1:Sprite) : void
      {
         contexMenuItem = new ContextMenuItem("");
         param1.contextMenu = new ContextMenu();
         param1.contextMenu.customItems.push(contexMenuItem);
         contexMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,contexMenuClicked);
      }
      
      private static function contexMenuClicked(param1:ContextMenuEvent) : void
      {
         navigateToURL(new URLRequest(getMoreGamesLink("Contex_Menu")));
      }
      
      spil_internal static function chooseLanguage() : void
      {
         if(cookieLanguage != null)
         {
            currentLanguage = cookieLanguage;
         }
         else if(isExternal)
         {
            currentLanguage = systemLanguage;
         }
         else
         {
            currentLanguage = portalLanguage;
            if(!currentLanguage)
            {
               currentLanguage = systemLanguage;
            }
         }
         if(!currentLanguage)
         {
            trace("Unable to determine language, using \'English US\'");
            currentLanguage = Languages.getLanguage("en_us");
         }
         TextFieldFit.embedFonts = currentLanguage.embedFonts;
         TextFieldFit.forceFont = currentLanguage.forceFont;
         dispatchEvent(new Event(LANGUAGE_CHANGED));
      }
      
      spil_internal static function chooseBranding() : void
      {
         currentBranding = Brandings.getBrandByDomain(currentLanguage.portal_groups[portalGroup]);
         if(!(currentBranding is Brand))
         {
            currentBranding = Brandings.getBrandByDomain("www.agame.com");
         }
         contexMenuItem.caption = "More Games: " + currentBranding.domain;
         dispatchEvent(new Event(BRANDING_CHANGED));
      }
      
      spil_internal static function changeLanguage(param1:String) : void
      {
         var _loc2_:Language = Languages.getLanguage(param1);
         if(!_loc2_)
         {
            trace("ERROR: Supplied language string does not have a matching language");
         }
         else
         {
            cookieLanguage = _loc2_;
            currentLanguage = _loc2_;
         }
         TextFieldFit.embedFonts = currentLanguage.embedFonts;
         TextFieldFit.forceFont = currentLanguage.forceFont;
         chooseBranding();
         dispatchEvent(new Event(LANGUAGE_CHANGED));
      }
      
      private static function get portalLanguage() : Language
      {
         var _loc1_:Brand = null;
         var _loc2_:String = null;
         var _loc3_:Language = null;
         if(isExternal)
         {
            return null;
         }
         if(!embedDomain)
         {
            return null;
         }
         _loc1_ = Brandings.getBrandByDomain(embedDomain);
         if(!_loc1_)
         {
            return null;
         }
         _loc2_ = _loc1_.preferedLanguage;
         if(!_loc2_)
         {
            return null;
         }
         _loc3_ = Languages.getLanguage(_loc2_);
         if(!_loc3_)
         {
            return null;
         }
         return _loc3_;
      }
      
      spil_internal static function get systemLanguage() : Language
      {
         return Languages.getLanguage(Capabilities.language);
      }
      
      spil_internal static function get cookieLanguage() : Language
      {
         var _loc1_:SharedObject = SharedObject.getLocal(cookieName,cookiePath);
         var _loc2_:String = String(_loc1_.data[cookieLanguageVar]);
         return Languages.getLanguage(_loc2_);
      }
      
      spil_internal static function set cookieLanguage(param1:Language) : void
      {
         var _loc2_:SharedObject = SharedObject.getLocal(cookieName,cookiePath);
         if(param1 == null)
         {
            _loc2_.data[cookieLanguageVar] = null;
         }
         else
         {
            _loc2_.data[cookieLanguageVar] = param1.name;
         }
         _loc2_.flush();
      }
      
      public static function get isExternal() : Boolean
      {
         return !Brandings.hasDomain(embedDomain) && !localDomains[embedDomain] && !isStagingDomain;
      }
      
      public static function get isStagingDomain() : Boolean
      {
         var _loc1_:String = "http://" + embedDomain;
         return _loc1_.indexOf("http://stg.") >= 0;
      }
      
      spil_internal static function get hostingDomain() : String
      {
         var _loc1_:LocalConnection = null;
         if(debugHostDomain != "")
         {
            return debugHostDomain;
         }
         _loc1_ = new LocalConnection();
         return _loc1_.domain;
      }
      
      spil_internal static function get embedDomain() : String
      {
         var loc:String = null;
         if(debugEmbedDomain != "")
         {
            return debugEmbedDomain;
         }
         if(ExternalInterface.available)
         {
            try
            {
               loc = ExternalInterface.call("window.location.href.toString");
               if(loc != "" && loc != null)
               {
                  trace("embed domain = " + getDomain(loc));
                  return getDomain(loc);
               }
            }
            catch(e:SecurityError)
            {
               trace("Security Error connecting to external interface, error = " + e);
            }
            catch(e:Error)
            {
               trace("Error connecting to external interface, error = " + e);
            }
         }
         return null;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(!eventDispatcher)
         {
            eventDispatcher = new EventDispatcher();
         }
         eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(!eventDispatcher)
         {
            eventDispatcher = new EventDispatcher();
         }
         eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      spil_internal static function dispatchEvent(param1:Event) : void
      {
         if(!eventDispatcher)
         {
            eventDispatcher = new EventDispatcher();
         }
         eventDispatcher.dispatchEvent(param1);
      }
      
      public static function exportXML() : XML
      {
         var _loc1_:XML = <spil_games/>;
         _loc1_.appendChild(Brandings.exportXML());
         _loc1_.appendChild(Languages.exportXML());
         _loc1_.appendChild(PortalGroup.exportXML());
         return _loc1_;
      }
      
      private static function getDomain(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         if(param1.indexOf("file") == 0)
         {
            return "offline_play";
         }
         _loc2_ = new String();
         _loc3_ = 7;
         while(_loc3_ < param1.length)
         {
            if(param1.charAt(_loc3_) == "/")
            {
               break;
            }
            _loc2_ += param1.charAt(_loc3_);
            _loc3_++;
         }
         if(_loc2_ == "localhost")
         {
            _loc2_ = "offline_play";
         }
         return _loc2_;
      }
   }
}

