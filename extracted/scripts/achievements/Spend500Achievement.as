package achievements
{
   import flash.geom.Rectangle;
   
   public class Spend500Achievement extends Achievement
   {
      
      public function Spend500Achievement()
      {
         super(Localizer.Instance.medal_spend_500);
         this.award_type = "medal_spend_500";
         check(false);
         image_rect = new Rectangle(0,60,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.MONEY_SPENT) >= 500)
         {
            return true;
         }
         return false;
      }
   }
}

