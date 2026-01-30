package achievements
{
   import flash.geom.Rectangle;
   
   public class RapidTower5Achievement extends Achievement
   {
      
      public function RapidTower5Achievement()
      {
         super(Localizer.Instance.medal_minigun_5);
         this.award_type = "medal_minigun_5";
         check(false);
         image_rect = new Rectangle(60,180,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.RAPID_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

