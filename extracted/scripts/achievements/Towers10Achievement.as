package achievements
{
   import flash.geom.Rectangle;
   
   public class Towers10Achievement extends Achievement
   {
      
      public function Towers10Achievement()
      {
         super(Localizer.Instance.medal_towers_10);
         this.award_type = "medal_tower_10";
         check(false);
         image_rect = new Rectangle(180,240,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.TOWERS_PURCHASED) >= 10)
         {
            return true;
         }
         return false;
      }
   }
}

