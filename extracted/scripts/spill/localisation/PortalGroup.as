package spill.localisation
{
   import flash.xml.XMLNode;
   
   use namespace spil_internal;
   
   public class PortalGroup
   {
      
      public static const FAMILY:uint = 0;
      
      public static const TEENS:uint = 1;
      
      public static const GIRL:uint = 2;
      
      public static const YOUNG_ADULTS:uint = 3;
      
      public static const ZAPAPA:uint = 4;
      
      public static const HYVES:uint = 5;
      
      public static const NONE:uint = 6;
      
      public static const channelNames:Array = ["family","tween","girl","teen","zapapa","hyves"];
      
      public static const backgroundColors:Array = [16777215,16777215,16742331,16777215,16777215,16777215];
      
      public function PortalGroup()
      {
         super();
      }
      
      public static function getName(param1:int) : String
      {
         return channelNames[param1];
      }
      
      public static function exportXML() : XMLNode
      {
         var _loc3_:XMLNode = null;
         var _loc1_:XMLNode = new XMLNode(1,"channels");
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new XMLNode(1,"channel");
            _loc3_.attributes.name = channelNames[_loc2_];
            _loc3_.attributes.id = _loc2_;
            _loc1_.appendChild(_loc3_);
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

