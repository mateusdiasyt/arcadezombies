package achievements
{
   import flash.geom.Rectangle;
   
   public class TimePlayed120Achievement extends Achievement
   {
      
      public function TimePlayed120Achievement()
      {
         super(Localizer.Instance.medal_time_played_120);
         this.award_type = "medal_time_played_120";
         check(false);
         image_rect = new Rectangle(120,0,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         var time_played:Number = Globals.tracker.getNumber(Tracker.TIME_PLAYED) / (1000 * 60);
         if(time_played > 120)
         {
            return true;
         }
         return false;
      }
   }
}

