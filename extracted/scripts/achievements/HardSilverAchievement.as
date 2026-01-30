package achievements
{
   import flash.geom.Rectangle;
   
   public class HardSilverAchievement extends Achievement
   {
      
      public function HardSilverAchievement()
      {
         super(Localizer.Instance.medal_hard_silver);
         this.award_type = "medal_hard_silver";
         check(false);
         image_rect = new Rectangle(60,420,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.HARD_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_HARD_WIN_SCORE) >= 45000)
         {
            return true;
         }
         return false;
      }
   }
}

