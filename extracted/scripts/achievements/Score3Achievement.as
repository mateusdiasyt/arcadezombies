package achievements
{
   import flash.geom.Rectangle;
   
   public class Score3Achievement extends Achievement
   {
      
      public function Score3Achievement()
      {
         super(Localizer.Instance.medal_score_3);
         this.award_type = "medal_score_3";
         check(false);
         image_rect = new Rectangle(120,240,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.HIGHEST_SCORE) >= 100000)
         {
            return true;
         }
         return false;
      }
   }
}

