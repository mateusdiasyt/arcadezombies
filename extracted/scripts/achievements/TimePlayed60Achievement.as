package achievements
{
   import flash.geom.Rectangle;
   
   public class TimePlayed60Achievement extends Achievement
   {
      
      public function TimePlayed60Achievement()
      {
         super(Localizer.Instance.medal_time_played_60);
         this.award_type = "medal_time_played_60";
         check(false);
         image_rect = new Rectangle(60,0,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         var time_played:Number = Globals.tracker.getNumber(Tracker.TIME_PLAYED) / (1000 * 60);
         if(time_played >= 60)
         {
            return true;
         }
         return false;
      }
   }
}

