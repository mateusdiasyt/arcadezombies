package achievements
{
   import flash.geom.Rectangle;
   
   public class TimePlayed30Achievement extends Achievement
   {
      
      public function TimePlayed30Achievement()
      {
         super(Localizer.Instance.medal_time_played_30);
         this.award_type = "medal_time_played_30";
         check(false);
         image_rect = new Rectangle(0,0,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         var time_played:Number = Globals.tracker.getNumber(Tracker.TIME_PLAYED) / (1000 * 60);
         if(time_played >= 30)
         {
            return true;
         }
         return false;
      }
   }
}

