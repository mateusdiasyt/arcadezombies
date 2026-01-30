package entities.towers.sentry
{
   import net.flashpunk.graphics.Image;
   
   public class SentryTower3 extends SentryTower
   {
      
      public function SentryTower3()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sentry"][3]);
         this.name = Towers.sentry[3].name;
         this.level = 3;
         this.range = Towers.sentry[3].range;
         this.speed = Towers.sentry[3].speed;
         this.damage = Towers.sentry[3].damage;
         this.bullet_speed = Towers.sentry[3].bullet_speed;
         this.cost = Towers.sentry[3].cost;
         this.upgrade_cost = Towers.sentry[3].upgrade_cost;
         this.upgrade_to = Towers.sentry[3].upgrade_to;
      }
   }
}

