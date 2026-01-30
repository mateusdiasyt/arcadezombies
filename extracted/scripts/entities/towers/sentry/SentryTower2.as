package entities.towers.sentry
{
   import net.flashpunk.graphics.Image;
   
   public class SentryTower2 extends SentryTower
   {
      
      public function SentryTower2()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sentry"][2]);
         this.name = Towers.sentry[2].name;
         this.level = 2;
         this.range = Towers.sentry[2].range;
         this.speed = Towers.sentry[2].speed;
         this.damage = Towers.sentry[2].damage;
         this.bullet_speed = Towers.sentry[2].bullet_speed;
         this.cost = Towers.sentry[2].cost;
         this.upgrade_cost = Towers.sentry[2].upgrade_cost;
         this.upgrade_to = Towers.sentry[2].upgrade_to;
      }
   }
}

