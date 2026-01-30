package achievements
{
   import flash.geom.Rectangle;
   
   public class Score2Achievement extends Achievement
   {
      
      public function Score2Achievement()
      {
         super(Localizer.Instance.medal_score_2);
         this.award_type = "medal_score_2";
         check(false);
         image_rect = new Rectangle(60,240,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.HIGHEST_SCORE) >= 50000)
         {
            return true;
         }
         return false;
      }
   }
}

