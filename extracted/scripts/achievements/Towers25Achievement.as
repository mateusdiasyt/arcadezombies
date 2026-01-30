package achievements
{
   import flash.geom.Rectangle;
   
   public class Towers25Achievement extends Achievement
   {
      
      public function Towers25Achievement()
      {
         super(Localizer.Instance.medal_towers_25);
         this.award_type = "medal_tower_25";
         check(false);
         image_rect = new Rectangle(240,240,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.TOWERS_PURCHASED) >= 25)
         {
            return true;
         }
         return false;
      }
   }
}

