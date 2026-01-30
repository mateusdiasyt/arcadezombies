package achievements
{
   import flash.geom.Rectangle;
   
   public class Killer50Achievement extends Achievement
   {
      
      public function Killer50Achievement()
      {
         super(Localizer.Instance.medal_killer_50);
         this.award_type = "medal_killer_50";
         check(false);
         image_rect = new Rectangle(180,0,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         var killed:Number = Globals.tracker.getNumber(Tracker.ZOMBIES_KILLED);
         if(killed >= 50)
         {
            return true;
         }
         return false;
      }
   }
}

