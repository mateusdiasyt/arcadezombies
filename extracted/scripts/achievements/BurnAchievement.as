package achievements
{
   import flash.geom.Rectangle;
   
   public class BurnAchievement extends Achievement
   {
      
      public function BurnAchievement()
      {
         super(Localizer.Instance.medal_burn);
         this.award_type = "medal_burn";
         check(false);
         image_rect = new Rectangle(180,60,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.ZOMBIES_BURNED) >= 100)
         {
            return true;
         }
         return false;
      }
   }
}

