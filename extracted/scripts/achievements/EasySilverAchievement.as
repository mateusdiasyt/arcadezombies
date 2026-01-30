package achievements
{
   import flash.geom.Rectangle;
   
   public class EasySilverAchievement extends Achievement
   {
      
      public function EasySilverAchievement()
      {
         super(Localizer.Instance.medal_easy_silver);
         this.award_type = "medal_easy_silver";
         check(false);
         image_rect = new Rectangle(60,360,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EASY_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_EASY_WIN_SCORE) >= 15000)
         {
            return true;
         }
         return false;
      }
   }
}

