package spill.localisation
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   use namespace spil_internal;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3")]
   public class LanguageSelectBox extends MovieClip
   {
      
      private var popup:MovieClip;
      
      private var flag:MovieClip;
      
      private var languageName_text:TextField;
      
      private var mc:MovieClip;
      
      public function LanguageSelectBox()
      {
         trace("new langselecbox");
         super();
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         addEventListener(Event.ADDED_TO_STAGE,added,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,removed,false,0,true);
         addEventListener(MouseEvent.MOUSE_OVER,mouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,mouseOut,false,0,true);
         spil_internal::Languages.initialize();
         popup = new spil_internal::LanguageSelectPopup_mc();
         x = Math.round(x);
         y = Math.round(y);
         popup.y = -Math.floor(popup.height) + 1;
         popup.visible = false;
         addChild(popup);
         mc = new spil_internal::LanguageSelectBox_mc();
         addChild(mc);
         flag = mc.flag;
         languageName_text = mc.languageName_text;
         if(Boolean(stage))
         {
            added();
         }
         init();
         languageChanged();
      }
      
      public function init() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Language = null;
         trace("initselectbox");
         var _loc1_:Array = new Array(popup.l_br,popup.l_de,popup.l_en_us,popup.l_fr,popup.l_in,popup.l_jp,popup.l_pt,popup.l_ru,popup.l_ar,popup.l_cn,popup.l_en_uk,popup.l_es,popup.l_id,popup.l_it,popup.l_nl,popup.l_pl,popup.l_se,popup.l_es_mx,popup.l_es_ar);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = MovieClip(_loc1_[_loc2_]);
            if(Boolean(_loc3_))
            {
               _loc3_.addEventListener(MouseEvent.CLICK,itemClicked,true,0,true);
               _loc3_.flag.gotoAndStop(_loc3_.name.substr(2));
               _loc3_.flag.mouseEnabled = false;
               _loc3_.text.mouseEnabled = false;
               _loc4_ = spil_internal::Languages.getLanguage(_loc3_.name.substr(2));
               if(Boolean(_loc4_))
               {
                  _loc3_.text.text = _loc4_.displayAcronim;
               }
               else
               {
                  trace("Error, \'" + _loc3_.name.substr(2) + "\' language not found");
               }
            }
            else
            {
               trace("Error, btn number \'" + _loc2_ + "\' is not a MovieClip or there is no button \'" + _loc1_[_loc2_] + "\'");
            }
            _loc2_++;
         }
      }
      
      private function itemClicked(param1:MouseEvent) : void
      {
         spil_internal::SpilGame.spil_internal::changeLanguage(param1.currentTarget.name.substr(2));
         popup.visible = false;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         popup.visible = true;
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         popup.visible = false;
      }
      
      private function added(param1:Event = null) : void
      {
         trace("addedselebnox");
         spil_internal::SpilGame.addEventListener("languageChanged",languageChanged,false,0,true);
      }
      
      private function removed(param1:Event) : void
      {
         spil_internal::SpilGame.removeEventListener("languageChanged",languageChanged);
      }
      
      private function languageChanged(param1:Event = null) : void
      {
         if(Boolean(spil_internal::SpilGame.currentLanguage))
         {
            if(spil_internal::SpilGame.spil_internal::portalGroup == spil_internal::PortalGroup.HYVES && spil_internal::SpilGame.currentLanguage.name == "nl")
            {
               this.visible = false;
               return;
            }
            this.visible = true;
            flag.gotoAndStop(spil_internal::SpilGame.currentLanguage.name);
            languageName_text.text = spil_internal::SpilGame.currentLanguage.displayName;
            languageName_text.embedFonts = spil_internal::SpilGame.currentLanguage.embedInputFonts;
         }
      }
      
      [Inspectable(name="Popup Location",enumeration="top,bottom",defaultValue="top")]
      public function set popupLocation(param1:String) : void
      {
         trace("popupLocation = " + param1);
         if(param1 == "bottom")
         {
            popup.y = Math.floor(mc.height);
         }
         else
         {
            popup.y = -Math.floor(mc.height) + 1;
         }
      }
   }
}

