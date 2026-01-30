package achievements
{
   import flash.geom.Rectangle;
   
   public class InsaneSilverAchievement extends Achievement
   {
      
      public function InsaneSilverAchievement()
      {
         super(Localizer.Instance.medal_insane_silver);
         this.award_type = "medal_insane_silver";
         check(false);
         image_rect = new Rectangle(240,420,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.INSANE_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_INSANE_WIN_SCORE) >= 85000)
         {
            return true;
         }
         return false;
      }
   }
}

