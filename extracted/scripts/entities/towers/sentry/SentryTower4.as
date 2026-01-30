package entities.towers.sentry
{
   import net.flashpunk.graphics.Image;
   
   public class SentryTower4 extends SentryTower
   {
      
      public function SentryTower4()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sentry"][4]);
         this.name = Towers.sentry[4].name;
         this.level = 4;
         this.range = Towers.sentry[4].range;
         this.speed = Towers.sentry[4].speed;
         this.damage = Towers.sentry[4].damage;
         this.bullet_speed = Towers.sentry[4].bullet_speed;
         this.cost = Towers.sentry[4].cost;
         this.upgrade_cost = Towers.sentry[4].upgrade_cost;
         this.upgrade_to = Towers.sentry[4].upgrade_to;
      }
   }
}

