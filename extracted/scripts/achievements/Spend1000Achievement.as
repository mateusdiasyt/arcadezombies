package achievements
{
   import flash.geom.Rectangle;
   
   public class Spend1000Achievement extends Achievement
   {
      
      public function Spend1000Achievement()
      {
         super(Localizer.Instance.medal_spend_1000);
         this.award_type = "medal_spend_1000";
         check(false);
         image_rect = new Rectangle(60,60,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.MONEY_SPENT) >= 1000)
         {
            return true;
         }
         return false;
      }
   }
}

