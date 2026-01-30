package achievements
{
   import flash.geom.Rectangle;
   
   public class BombTower5Achievement extends Achievement
   {
      
      public function BombTower5Achievement()
      {
         super(Localizer.Instance.medal_cannon_5);
         this.award_type = "medal_cannon_5";
         check(false);
         image_rect = new Rectangle(60,120,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.BOMB_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

