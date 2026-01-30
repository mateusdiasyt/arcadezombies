package entities.towers.sensor
{
   import entities.TowerEntity;
   import net.flashpunk.graphics.Image;
   
   public class SensorTower extends TowerEntity
   {
      
      public function SensorTower(base:int = 3, level:int = 15)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["sensor"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sensor"][1]);
         this.bullet = Assets.GFX_SENTRY_BULLET;
         this.muzzle_flash = null;
         this.no_targetting = true;
         this.type = "SensorTower";
         this.disable_targetting = true;
         this.level = 1;
         this.tower_type = "sensor";
         this.name = Towers.sensor[this.level].name;
         this.damage_display = Towers.sensor[this.level].damage_display;
         this.range_display = Towers.sensor[this.level].range_display;
         this.speed_display = Towers.sensor[this.level].speed_display;
         this.effect_display = Towers.sensor[this.level].effect_display;
         this.portrait_index = Towers.sensor[this.level].portrait_index;
         this.range = Towers.sensor[this.level].range;
         this.speed = Towers.sensor[this.level].speed;
         this.damage = Towers.sensor[this.level].damage;
         this.cost = Towers.sensor[this.level].cost;
         this.upgrade_cost = Towers.sensor[this.level].upgrade_cost;
         this.upgrade_to = Towers.sensor[this.level].upgrade_to;
      }
      
      override public function update() : void
      {
         super.update();
         if(placed)
         {
            this.turret.angle -= 3;
         }
      }
      
      override public function added() : void
      {
         super.added();
      }
      
      override protected function shoot() : void
      {
      }
   }
}

