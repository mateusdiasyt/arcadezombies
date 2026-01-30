package achievements
{
   import flash.geom.Rectangle;
   
   public class NormalSilverAchievement extends Achievement
   {
      
      public function NormalSilverAchievement()
      {
         super(Localizer.Instance.medal_normal_silver);
         this.award_type = "medal_normal_silver";
         check(false);
         image_rect = new Rectangle(240,360,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.NORMAL_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_NORMAL_WIN_SCORE) >= 25000)
         {
            return true;
         }
         return false;
      }
   }
}

