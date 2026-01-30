package entities.towers.rapid
{
   import achievements.Tracker;
   import net.flashpunk.graphics.Image;
   
   public class RapidTower5 extends RapidTower
   {
      
      public function RapidTower5()
      {
         super(7,39);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["rapid"][5]);
         this.level = 5;
         this.name = Towers.rapid[this.level].name;
         this.range = Towers.rapid[this.level].range;
         this.speed = Towers.rapid[this.level].speed;
         this.damage = Towers.rapid[this.level].damage;
         this.cost = Towers.rapid[this.level].cost;
         this.upgrade_cost = Towers.rapid[this.level].upgrade_cost;
         this.upgrade_to = Towers.rapid[this.level].upgrade_to;
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.RAPID_LEVEL_5,1);
         super.tower_placed();
      }
      
      override public function added() : void
      {
         super.added();
         muzzle_flash.x = -18;
         muzzle_flash.y = 9;
         muzzle_flash.originX = 33;
         muzzle_flash.originY = 6;
      }
   }
}

