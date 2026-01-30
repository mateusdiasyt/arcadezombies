package entities.towers.laser
{
   import achievements.Tracker;
   import entities.bullets.Laser;
   import net.flashpunk.graphics.Image;
   
   public class LaserTower5 extends LaserTower
   {
      
      public function LaserTower5()
      {
         super(8,44);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["laser"][5]);
         this.level = 5;
         this.name = Towers.laser[this.level].name;
         this.range = Towers.laser[this.level].range;
         this.speed = Towers.laser[this.level].speed;
         this.damage = Towers.laser[this.level].damage;
         this.cost = Towers.laser[this.level].cost;
         this.upgrade_cost = Towers.laser[this.level].upgrade_cost;
         this.upgrade_to = Towers.laser[this.level].upgrade_to;
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.LASER_LEVEL_5,1);
         super.tower_placed();
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_LASER);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 15;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 15;
         _shoot_target = this.target;
         var laser:Laser = new Laser(bx,by,this,this.target,5);
      }
   }
}

