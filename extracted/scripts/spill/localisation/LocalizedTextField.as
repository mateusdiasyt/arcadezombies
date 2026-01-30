package spill.localisation
{
   import flash.events.Event;
   
   use namespace spil_internal;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol145")]
   public class LocalizedTextField extends TextFieldFit
   {
      
      private var originalText:String;
      
      private var regex:RegExp = /{([^{}]*)}/g;
      
      public function LocalizedTextField()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,added,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,removed,false,0,true);
         added();
      }
      
      private function added(param1:Event = null) : void
      {
         spil_internal::SpilGame.addEventListener("languageChanged",languageChanged,false,0,true);
         text = originalText;
      }
      
      private function removed(param1:Event) : void
      {
         spil_internal::SpilGame.removeEventListener("languageChanged",languageChanged);
      }
      
      private function languageChanged(param1:Event) : void
      {
         text = originalText;
         updateProperties();
      }
      
      override public function set text(param1:String) : void
      {
         originalText = param1;
         if(param1 is String)
         {
            super.text = param1.replace(regex,replaceFn);
         }
         else
         {
            super.text = "";
         }
         trace(super.text);
      }
      
      private function replaceFn() : String
      {
         var _loc2_:String = spil_internal::SpilGame.getString(arguments[1]);
         if(!_loc2_ || _loc2_ == "")
         {
            return "{" + arguments[1] + "}";
         }
         return _loc2_;
      }
   }
}

