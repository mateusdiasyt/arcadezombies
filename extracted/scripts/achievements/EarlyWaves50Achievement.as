package achievements
{
   import flash.geom.Rectangle;
   
   public class EarlyWaves50Achievement extends Achievement
   {
      
      public function EarlyWaves50Achievement()
      {
         super(Localizer.Instance.medal_early_50);
         this.award_type = "medal_early_50";
         check(false);
         image_rect = new Rectangle(60,300,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.EARLY_WAVE) >= 50)
         {
            return true;
         }
         return false;
      }
   }
}

