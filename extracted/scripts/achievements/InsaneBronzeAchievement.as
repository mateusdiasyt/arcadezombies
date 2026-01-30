package achievements
{
   import flash.geom.Rectangle;
   
   public class InsaneBronzeAchievement extends Achievement
   {
      
      public function InsaneBronzeAchievement()
      {
         super(Localizer.Instance.medal_insane_bronze);
         this.award_type = "medal_insane_bronze";
         check(false);
         image_rect = new Rectangle(300,420,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.INSANE_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_INSANE_WIN_SCORE) >= 0)
         {
            return true;
         }
         return false;
      }
   }
}

