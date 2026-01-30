package spill.localisation
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   use namespace spil_internal;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol139")]
   public class BrandingLogo extends MovieClip
   {
      
      public function BrandingLogo()
      {
         addFrameScript(0,spil_internal::frame1);
         super();
         stop();
         mouseEnabled = false;
         mouseChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,added,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,removed,false,0,true);
         if(Boolean(stage))
         {
            added();
         }
         brandingChanged();
      }
      
      private function added(param1:Event = null) : void
      {
         spil_internal::SpilGame.addEventListener("brandingChanged",brandingChanged,false,0,true);
         brandingChanged();
      }
      
      private function removed(param1:Event) : void
      {
         spil_internal::SpilGame.removeEventListener("brandingChanged",brandingChanged);
      }
      
      private function brandingChanged(param1:Event = null) : void
      {
         if(Boolean(spil_internal::SpilGame.currentBranding))
         {
            gotoAndStop(spil_internal::SpilGame.currentBranding.domain);
         }
      }
      
      spil_internal function frame1() : *
      {
         stop();
      }
   }
}

