package achievements
{
   import flash.geom.Rectangle;
   
   public class SensorTower5Achievement extends Achievement
   {
      
      public function SensorTower5Achievement()
      {
         super(Localizer.Instance.medal_sensor_5);
         this.award_type = "medal_sensor_5";
         check(false);
         image_rect = new Rectangle(180,120,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.SENSOR_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

