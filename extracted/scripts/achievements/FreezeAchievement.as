package achievements
{
   import flash.geom.Rectangle;
   
   public class FreezeAchievement extends Achievement
   {
      
      public function FreezeAchievement()
      {
         super(Localizer.Instance.medal_freeze);
         this.award_type = "medal_freeze";
         check(false);
         image_rect = new Rectangle(240,60,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.ZOMBIES_FROZEN) >= 100)
         {
            return true;
         }
         return false;
      }
   }
}

