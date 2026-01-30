package spill.localisation
{
   import flash.xml.XMLNode;
   
   use namespace spil_internal;
   
   public class Language
   {
      
      public var name:String;
      
      public var dname:String;
      
      public var id:uint;
      
      public var portal_groups:Array;
      
      public var textLanguage:String;
      
      public var embedFonts:Boolean = true;
      
      public var embedInputFonts:Boolean = true;
      
      public var forceFont:String = null;
      
      public var bwcId:int;
      
      public var references:Array = [];
      
      public var displayName:String = "";
      
      public function Language(param1:String, param2:String = null)
      {
         super();
         name = param1;
         dname = param2;
         portal_groups = new Array();
      }
      
      public function get displayAcronim() : String
      {
         return Boolean(dname) ? dname : name;
      }
      
      public function set p_family(param1:String) : void
      {
         portal_groups[PortalGroup.FAMILY] = param1;
      }
      
      public function get p_family() : String
      {
         return portal_groups[PortalGroup.FAMILY];
      }
      
      public function set p_tween(param1:String) : void
      {
         portal_groups[PortalGroup.TEENS] = param1;
      }
      
      public function get p_tween() : String
      {
         return portal_groups[PortalGroup.TEENS];
      }
      
      public function set p_girl(param1:String) : void
      {
         portal_groups[PortalGroup.GIRL] = param1;
      }
      
      public function get p_girl() : String
      {
         trace("Language",portal_groups[PortalGroup.GIRL]);
         return portal_groups[PortalGroup.GIRL];
      }
      
      public function set p_teen(param1:String) : void
      {
         portal_groups[PortalGroup.YOUNG_ADULTS] = param1;
      }
      
      public function get p_teen() : String
      {
         return portal_groups[PortalGroup.YOUNG_ADULTS];
      }
      
      public function set p_zapapa(param1:String) : void
      {
         portal_groups[PortalGroup.ZAPAPA] = param1;
      }
      
      public function get p_zapapa() : String
      {
         return portal_groups[PortalGroup.ZAPAPA];
      }
      
      public function set p_hyves(param1:String) : void
      {
         portal_groups[PortalGroup.HYVES] = param1;
      }
      
      public function get p_hyves() : String
      {
         return portal_groups[PortalGroup.HYVES];
      }
      
      public function exportXML() : XMLNode
      {
         var _loc1_:XMLNode = new XMLNode(1,"language");
         _loc1_.attributes.name = name;
         if(textLanguage != null)
         {
            _loc1_.attributes.textLanguage = textLanguage;
         }
         if(Boolean(references.length))
         {
            _loc1_.attributes.references = references.toString();
         }
         _loc1_.attributes.id = bwcId;
         var _loc2_:XMLNode = new XMLNode(1,"display_name");
         _loc2_.firstChild = new XMLNode(3,displayName);
         _loc1_.appendChild(_loc2_);
         var _loc3_:Array = [];
         var _loc4_:Array = PortalGroup.channelNames;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_.push(Brandings.getBrandByDomain(portal_groups[_loc5_]).site_id);
            _loc5_++;
         }
         _loc1_.attributes.channels = _loc3_.join(",");
         return _loc1_;
      }
   }
}

