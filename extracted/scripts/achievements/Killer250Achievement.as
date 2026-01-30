package achievements
{
   import flash.geom.Rectangle;
   
   public class Killer250Achievement extends Achievement
   {
      
      public function Killer250Achievement()
      {
         super(Localizer.Instance.medal_killer_250);
         this.award_type = "medal_killer_250";
         check(false);
         image_rect = new Rectangle(240,0,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         var killed:Number = Globals.tracker.getNumber(Tracker.ZOMBIES_KILLED);
         if(killed >= 250)
         {
            return true;
         }
         return false;
      }
   }
}

