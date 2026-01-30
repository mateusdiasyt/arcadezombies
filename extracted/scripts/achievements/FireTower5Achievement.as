package achievements
{
   import flash.geom.Rectangle;
   
   public class FireTower5Achievement extends Achievement
   {
      
      public function FireTower5Achievement()
      {
         super(Localizer.Instance.medal_fire_5);
         this.award_type = "medal_fire_5";
         check(false);
         image_rect = new Rectangle(300,120,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.FIRE_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

