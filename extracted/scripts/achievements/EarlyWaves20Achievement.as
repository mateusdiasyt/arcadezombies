package achievements
{
   import flash.geom.Rectangle;
   
   public class EarlyWaves20Achievement extends Achievement
   {
      
      public function EarlyWaves20Achievement()
      {
         super(Localizer.Instance.medal_early_20);
         this.award_type = "medal_early_20";
         check(false);
         image_rect = new Rectangle(0,300,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EARLY_WAVE) >= 20)
         {
            return true;
         }
         return false;
      }
   }
}

