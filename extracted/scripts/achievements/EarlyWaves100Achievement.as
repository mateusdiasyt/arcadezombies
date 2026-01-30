package achievements
{
   import flash.geom.Rectangle;
   
   public class EarlyWaves100Achievement extends Achievement
   {
      
      public function EarlyWaves100Achievement()
      {
         super(Localizer.Instance.medal_early_100);
         this.award_type = "medal_early_100";
         check(false);
         image_rect = new Rectangle(120,300,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EARLY_WAVE) >= 100)
         {
            return true;
         }
         return false;
      }
   }
}

