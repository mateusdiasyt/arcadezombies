package entities.towers.sentry
{
   import entities.TowerEntity;
   import entities.bullets.Bullet;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class SentryTower extends TowerEntity
   {
      
      public function SentryTower(base:int = 0, level:int = 0)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["sentry"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sentry"][1]);
         this.bullet = Assets.GFX_SENTRY_BULLET;
         this.muzzle_flash = new Image(Assets.GFX_SENTRY_FLASH);
         this.level = 1;
         this.tower_type = "sentry";
         this.name = Towers.sentry[this.level].name;
         this.damage_display = Towers.sentry[this.level].damage_display;
         this.range_display = Towers.sentry[this.level].range_display;
         this.speed_display = Towers.sentry[this.level].speed_display;
         this.effect_display = Towers.sentry[this.level].effect_display;
         this.portrait_index = Towers.sentry[this.level].portrait_index;
         this.range = Towers.sentry[this.level].range;
         this.speed = Towers.sentry[this.level].speed;
         this.damage = Towers.sentry[this.level].damage;
         this.bullet_speed = Towers.sentry[this.level].bullet_speed;
         this.cost = Towers.sentry[this.level].cost;
         this.upgrade_cost = Towers.sentry[this.level].upgrade_cost;
         this.upgrade_to = Towers.sentry[this.level].upgrade_to;
      }
      
      override public function added() : void
      {
         super.added();
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_SENTRY);
         var bx:Number = this.centerX;
         var by:Number = this.centerY;
         FP.world.add(Bullet.create(this.bullet,this,bx,by));
      }
   }
}

