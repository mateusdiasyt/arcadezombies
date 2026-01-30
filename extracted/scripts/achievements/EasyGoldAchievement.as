package achievements
{
   import flash.geom.Rectangle;
   
   public class EasyGoldAchievement extends Achievement
   {
      
      public function EasyGoldAchievement()
      {
         super(Localizer.Instance.medal_easy_gold);
         this.award_type = "medal_easy_gold";
         check(false);
         image_rect = new Rectangle(0,360,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EASY_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_EASY_WIN_SCORE) >= 19000)
         {
            return true;
         }
         return false;
      }
   }
}

