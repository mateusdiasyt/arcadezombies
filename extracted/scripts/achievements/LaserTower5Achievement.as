package achievements
{
   import flash.geom.Rectangle;
   
   public class LaserTower5Achievement extends Achievement
   {
      
      public function LaserTower5Achievement()
      {
         super(Localizer.Instance.medal_laser_5);
         this.award_type = "medal_laser_5";
         check(false);
         image_rect = new Rectangle(120,180,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.LASER_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

