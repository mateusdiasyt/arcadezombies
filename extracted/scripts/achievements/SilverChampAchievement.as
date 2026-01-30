package achievements
{
   import flash.geom.Rectangle;
   
   public class SilverChampAchievement extends Achievement
   {
      
      public function SilverChampAchievement()
      {
         super(Localizer.Instance.medal_silver_champ);
         this.award_type = "award4";
         check(false);
         image_rect = new Rectangle(240,300,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EASY_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_EASY_WIN_SCORE) >= 15000 && Globals.tracker.getNumber(Tracker.NORMAL_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_NORMAL_WIN_SCORE) >= 25000 && Globals.tracker.getNumber(Tracker.HARD_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_HARD_WIN_SCORE) >= 45000 && Globals.tracker.getNumber(Tracker.INSANE_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_INSANE_WIN_SCORE) >= 85000)
         {
            return true;
         }
         return false;
      }
   }
}

