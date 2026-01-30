package entities.towers.sentry
{
   import achievements.Tracker;
   import net.flashpunk.graphics.Image;
   
   public class SentryTower5 extends SentryTower
   {
      
      public function SentryTower5()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sentry"][5]);
         this.name = Towers.sentry[5].name;
         this.level = 5;
         this.range = Towers.sentry[5].range;
         this.speed = Towers.sentry[5].speed;
         this.damage = Towers.sentry[5].damage;
         this.bullet_speed = Towers.sentry[5].bullet_speed;
         this.cost = Towers.sentry[5].cost;
         this.upgrade_cost = Towers.sentry[5].upgrade_cost;
         this.upgrade_to = Towers.sentry[5].upgrade_to;
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.SENTRY_LEVEL_5,1);
         super.tower_placed();
      }
   }
}

