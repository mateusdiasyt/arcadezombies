package achievements
{
   import flash.geom.Rectangle;
   
   public class Spend2500Achievement extends Achievement
   {
      
      public function Spend2500Achievement()
      {
         super(Localizer.Instance.medal_spend_2500);
         this.award_type = "medal_spend_2500";
         check(false);
         image_rect = new Rectangle(120,60,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.MONEY_SPENT) >= 2500)
         {
            return true;
         }
         return false;
      }
   }
}

