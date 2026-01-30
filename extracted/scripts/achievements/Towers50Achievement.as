package achievements
{
   import flash.geom.Rectangle;
   
   public class Towers50Achievement extends Achievement
   {
      
      public function Towers50Achievement()
      {
         super(Localizer.Instance.medal_towers_50);
         this.award_type = "medal_tower_50";
         check(false);
         image_rect = new Rectangle(300,240,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.TOWERS_PURCHASED) >= 50)
         {
            return true;
         }
         return false;
      }
   }
}

