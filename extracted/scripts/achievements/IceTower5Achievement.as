package achievements
{
   import flash.geom.Rectangle;
   
   public class IceTower5Achievement extends Achievement
   {
      
      public function IceTower5Achievement()
      {
         super(Localizer.Instance.medal_ice_5);
         this.award_type = "medal_ice_5";
         check(false);
         image_rect = new Rectangle(240,120,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.ICE_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

