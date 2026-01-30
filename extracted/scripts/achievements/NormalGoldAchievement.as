package achievements
{
   import flash.geom.Rectangle;
   
   public class NormalGoldAchievement extends Achievement
   {
      
      public function NormalGoldAchievement()
      {
         super(Localizer.Instance.medal_normal_gold);
         this.award_type = "medal_normal_gold";
         check(false);
         image_rect = new Rectangle(180,360,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.NORMAL_WINS) >= 1 && Globals.tracker.getNumber(Tracker.HIGHEST_NORMAL_WIN_SCORE) >= 33000)
         {
            return true;
         }
         return false;
      }
   }
}

