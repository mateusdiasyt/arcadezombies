package achievements
{
   import flash.geom.Rectangle;
   
   public class SentryTower5Achievement extends Achievement
   {
      
      public function SentryTower5Achievement()
      {
         super(Localizer.Instance.medal_sentry_5);
         this.award_type = "award3";
         check(false);
         image_rect = new Rectangle(0,120,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.SENTRY_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

