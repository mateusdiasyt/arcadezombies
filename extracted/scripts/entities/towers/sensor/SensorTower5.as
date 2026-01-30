package entities.towers.sensor
{
   import achievements.Tracker;
   import entities.bullets.Beam;
   import net.flashpunk.graphics.Image;
   
   public class SensorTower5 extends SensorTower
   {
      
      public function SensorTower5()
      {
         super(3,19);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["sensor"][5]);
         this.level = 5;
         this.name = Towers.sensor[this.level].name;
         this.range = Towers.sensor[this.level].range;
         this.speed = Towers.sensor[this.level].speed;
         this.damage = Towers.sensor[this.level].damage;
         this.upgrade_cost = Towers.sensor[this.level].upgrade_cost;
         this.cost = Towers.sensor[this.level].cost;
         this.upgrade_to = Towers.sensor[this.level].upgrade_to;
         this.stun_length = Towers.sensor[this.level].stun_length;
         this.stun_targets = Towers.sensor[this.level].stun_targets;
         this.damage_text = "Stun 2";
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.SENSOR_LEVEL_5,1);
         super.tower_placed();
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_SENSOR);
         var beams:Beam = new Beam(this,this.getZombiesInRange(),2,this.damage,this.stun_length,this.stun_targets);
      }
   }
}

