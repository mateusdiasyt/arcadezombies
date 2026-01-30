package achievements
{
   import flash.geom.Rectangle;
   
   public class Killer1000Achievement extends Achievement
   {
      
      public function Killer1000Achievement()
      {
         super(Localizer.Instance.medal_killer_1000);
         this.award_type = "medal_killer_1000";
         check(false);
         image_rect = new Rectangle(300,0,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         var killed:Number = Globals.tracker.getNumber(Tracker.ZOMBIES_KILLED);
         if(killed >= 1000)
         {
            return true;
         }
         return false;
      }
   }
}

