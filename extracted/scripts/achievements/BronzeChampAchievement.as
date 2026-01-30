package achievements
{
   import flash.geom.Rectangle;
   
   public class BronzeChampAchievement extends Achievement
   {
      
      public function BronzeChampAchievement()
      {
         super(Localizer.Instance.medal_bronze_champ);
         this.award_type = "award1";
         check(false);
         image_rect = new Rectangle(300,300,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EASY_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_EASY_WIN_SCORE) >= 0 && Globals.tracker.getNumber(Tracker.NORMAL_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_NORMAL_WIN_SCORE) >= 0 && Globals.tracker.getNumber(Tracker.HARD_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_HARD_WIN_SCORE) >= 0 && Globals.tracker.getNumber(Tracker.INSANE_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_INSANE_WIN_SCORE) >= 0)
         {
            return true;
         }
         return false;
      }
   }
}

