package achievements
{
   import flash.geom.Rectangle;
   
   public class BuzzsawTower5Achievement extends Achievement
   {
      
      public function BuzzsawTower5Achievement()
      {
         super(Localizer.Instance.medal_buzzsaw_5);
         this.award_type = "medal_buzzsaw_5";
         check(false);
         image_rect = new Rectangle(0,180,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.BUZZSAW_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

