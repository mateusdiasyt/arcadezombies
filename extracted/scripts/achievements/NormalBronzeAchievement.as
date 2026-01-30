package achievements
{
   import flash.geom.Rectangle;
   
   public class NormalBronzeAchievement extends Achievement
   {
      
      public function NormalBronzeAchievement()
      {
         super(Localizer.Instance.medal_normal_bronze);
         this.award_type = "medal_normal_bronze";
         check(false);
         image_rect = new Rectangle(300,360,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.NORMAL_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_NORMAL_WIN_SCORE) >= 0)
         {
            return true;
         }
         return false;
      }
   }
}

