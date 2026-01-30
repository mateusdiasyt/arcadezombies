package achievements
{
   import flash.geom.Rectangle;
   
   public class TowerChampAchievement extends Achievement
   {
      
      public function TowerChampAchievement()
      {
         super(Localizer.Instance.medal_tower_champ);
         this.award_type = "award5";
         check(false);
         image_rect = new Rectangle(180,180,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.SENTRY_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.BOMB_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.SAM_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.SENSOR_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.ICE_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.FIRE_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.BUZZSAW_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.RAPID_LEVEL_5) >= 1 && Globals.tracker.getNumber(Tracker.LASER_LEVEL_5) >= 1)
         {
            return true;
         }
         return false;
      }
   }
}

