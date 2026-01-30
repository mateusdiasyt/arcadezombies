package achievements
{
   import flash.geom.Rectangle;
   
   public class InsaneGoldAchievement extends Achievement
   {
      
      public function InsaneGoldAchievement()
      {
         super(Localizer.Instance.medal_insane_gold);
         this.award_type = "medal_insane_gold";
         check(false);
         image_rect = new Rectangle(180,420,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.INSANE_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_INSANE_WIN_SCORE) >= 105000)
         {
            return true;
         }
         return false;
      }
   }
}

