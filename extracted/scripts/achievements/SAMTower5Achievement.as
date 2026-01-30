package achievements
{
   import flash.geom.Rectangle;
   
   public class SAMTower5Achievement extends Achievement
   {
      
      public function SAMTower5Achievement()
      {
         super(Localizer.Instance.medal_sam_5);
         this.award_type = "medal_sam_5";
         check(false);
         image_rect = new Rectangle(120,120,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.SAM_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

