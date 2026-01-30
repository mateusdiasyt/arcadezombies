package achievements
{
   import flash.geom.Rectangle;
   
   public class HardGoldAchievement extends Achievement
   {
      
      public function HardGoldAchievement()
      {
         super(Localizer.Instance.medal_hard_gold);
         this.award_type = "medal_hard_gold";
         check(false);
         image_rect = new Rectangle(0,420,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.HARD_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_HARD_WIN_SCORE) >= 56000)
         {
            return true;
         }
         return false;
      }
   }
}

