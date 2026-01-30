package entities.towers.rapid
{
   import entities.TowerEntity;
   import entities.bullets.Bullet;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class RapidTower extends TowerEntity
   {
      
      public function RapidTower(base:int = 7, level:int = 35)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["rapid"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["rapid"][1]);
         this.bullet = Assets.GFX_SENTRY_BULLET;
         this.muzzle_flash = new Image(Assets.GFX_SENTRY_FLASH);
         this.level = 1;
         this.tower_type = "rapid";
         this.name = Towers.rapid[this.level].name;
         this.damage_display = Towers.rapid[this.level].damage_display;
         this.range_display = Towers.rapid[this.level].range_display;
         this.speed_display = Towers.rapid[this.level].speed_display;
         this.effect_display = Towers.rapid[this.level].effect_display;
         this.portrait_index = Towers.rapid[this.level].portrait_index;
         this.range = Towers.rapid[this.level].range;
         this.speed = Towers.rapid[this.level].speed;
         this.damage = Towers.rapid[this.level].damage;
         this.cost = Towers.rapid[this.level].cost;
         this.upgrade_cost = Towers.rapid[this.level].upgrade_cost;
         this.upgrade_to = Towers.rapid[this.level].upgrade_to;
      }
      
      override public function added() : void
      {
         super.added();
         muzzle_flash.x = -13;
         muzzle_flash.y = 9;
         muzzle_flash.originX = 28;
         muzzle_flash.originY = 6;
      }
      
      override protected function shoot() : void
      {
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 8;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 8;
         SoundManager.playSound(Assets.SFX_MACHINE_GUN);
         FP.world.add(Bullet.create(this.bullet,this,bx,by));
      }
   }
}

