package achievements
{
   import flash.geom.Rectangle;
   
   public class EasyBronzeAchievement extends Achievement
   {
      
      public function EasyBronzeAchievement()
      {
         super(Localizer.Instance.medal_easy_bronze);
         this.award_type = "medal_easy_bronze";
         check(false);
         image_rect = new Rectangle(120,360,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EASY_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_EASY_WIN_SCORE) >= 0)
         {
            return true;
         }
         return false;
      }
   }
}

