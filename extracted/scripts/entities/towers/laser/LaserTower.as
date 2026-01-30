package entities.towers.laser
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import entities.bullets.Laser;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class LaserTower extends TowerEntity
   {
      
      protected var _shoot_timer:Number = 0;
      
      protected var _shoot_target:ZombieEntity = null;
      
      public function LaserTower(base:int = 8, level:int = 40)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["laser"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["laser"][1]);
         this.bullet = Assets.GFX_SENTRY_BULLET;
         this.muzzle_flash = null;
         this.level = 1;
         this.tower_type = "laser";
         this.name = Towers.laser[this.level].name;
         this.damage_display = Towers.laser[this.level].damage_display;
         this.range_display = Towers.laser[this.level].range_display;
         this.speed_display = Towers.laser[this.level].speed_display;
         this.effect_display = Towers.laser[this.level].effect_display;
         this.portrait_index = Towers.laser[this.level].portrait_index;
         this.range = Towers.laser[this.level].range;
         this.speed = Towers.laser[this.level].speed;
         this.damage = Towers.laser[this.level].damage;
         this.cost = Towers.laser[this.level].cost;
         this.upgrade_cost = Towers.laser[this.level].upgrade_cost;
         this.upgrade_to = Towers.laser[this.level].upgrade_to;
      }
      
      override public function update() : void
      {
         var dir:Number = NaN;
         super.update();
         if(Boolean(this._shoot_target))
         {
            this._shoot_timer += FP.elapsed;
            dir = Math.atan2(this._shoot_target.centerY - this.centerY,this._shoot_target.centerX - this.centerX) * 180 / Math.PI;
            this.turret.angle = -dir + 180;
            if(this._shoot_timer >= 0.25)
            {
               this._shoot_target = null;
            }
         }
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_LASER);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 10;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 10;
         this._shoot_target = this.target;
         var laser:Laser = new Laser(bx,by,this,this.target,1);
      }
   }
}

