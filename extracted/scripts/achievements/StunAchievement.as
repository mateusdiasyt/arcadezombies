package achievements
{
   import flash.geom.Rectangle;
   
   public class StunAchievement extends Achievement
   {
      
      public function StunAchievement()
      {
         super(Localizer.Instance.medal_stun_100);
         this.award_type = "medal_stun_100";
         check(false);
         image_rect = new Rectangle(300,60,60,60);
      }
      
      override public function checkCondition() : Boolean
      {
         if(Globals.tracker.getNumber(Tracker.ZOMBIES_STUNNED) >= 100)
         {
            return true;
         }
         return false;
      }
   }
}

