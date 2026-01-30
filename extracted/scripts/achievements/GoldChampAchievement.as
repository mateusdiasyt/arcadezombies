package achievements
{
   import flash.geom.Rectangle;
   
   public class GoldChampAchievement extends Achievement
   {
      
      public function GoldChampAchievement()
      {
         super(Localizer.Instance.medal_gold_champ);
         this.award_type = "award2";
         check(false);
         image_rect = new Rectangle(180,300,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EASY_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_EASY_WIN_SCORE) >= 19000 && Globals.tracker.getNumber(Tracker.NORMAL_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_NORMAL_WIN_SCORE) >= 33000 && Globals.tracker.getNumber(Tracker.HARD_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_HARD_WIN_SCORE) >= 56000 && Globals.tracker.getNumber(Tracker.INSANE_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_INSANE_WIN_SCORE) >= 105000)
         {
            return true;
         }
         return false;
      }
   }
}

