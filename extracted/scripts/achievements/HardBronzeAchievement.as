package achievements
{
   import flash.geom.Rectangle;
   
   public class HardBronzeAchievement extends Achievement
   {
      
      public function HardBronzeAchievement()
      {
         super(Localizer.Instance.medal_hard_bronze);
         this.award_type = "medal_hard_bronze";
         check(false);
         image_rect = new Rectangle(120,420,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.HARD_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_HARD_WIN_SCORE) >= 0)
         {
            return true;
         }
         return false;
      }
   }
}

