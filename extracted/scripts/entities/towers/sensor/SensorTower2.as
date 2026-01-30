package entities.towers.sensor
{
   import net.flashpunk.graphics.Image;
   
   public class SensorTower2 extends SensorTower
   {
      
      public function SensorTower2()
      {
         super(3,16);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sensor"][2]);
         this.level = 2;
         this.name = Towers.sensor[this.level].name;
         this.range = Towers.sensor[this.level].range;
         this.speed = Towers.sensor[this.level].speed;
         this.damage = Towers.sensor[this.level].damage;
         this.upgrade_cost = Towers.sensor[this.level].upgrade_cost;
         this.cost = Towers.sensor[this.level].cost;
         this.upgrade_to = Towers.sensor[this.level].upgrade_to;
      }
   }
}

