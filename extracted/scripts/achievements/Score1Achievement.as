package achievements
{
   import flash.geom.Rectangle;
   
   public class Score1Achievement extends Achievement
   {
      
      public function Score1Achievement()
      {
         super(Localizer.Instance.medal_score_1);
         this.award_type = "medal_score_1";
         check(false);
         image_rect = new Rectangle(0,240,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.HIGHEST_SCORE) >= 25000)
         {
            return true;
         }
         return false;
      }
   }
}

