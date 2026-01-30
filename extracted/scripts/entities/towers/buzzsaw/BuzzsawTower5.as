package entities.towers.buzzsaw
{
   import achievements.Tracker;
   import net.flashpunk.graphics.Image;
   
   public class BuzzsawTower5 extends BuzzsawTower
   {
      
      public function BuzzsawTower5()
      {
         super(6,34);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw"][5]);
         this.reload = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw_reload"][5]);
         this.level = 5;
         this.name = Towers.buzzsaw[this.level].name;
         this.ground = Towers.buzzsaw[this.level].ground;
         this.air = Towers.buzzsaw[this.level].air;
         this.range = Towers.buzzsaw[this.level].range;
         this.speed = Towers.buzzsaw[this.level].speed;
         this.damage = Towers.buzzsaw[this.level].damage;
         this.cost = Towers.buzzsaw[this.level].cost;
         this.upgrade_cost = Towers.buzzsaw[this.level].upgrade_cost;
         this.upgrade_to = Towers.buzzsaw[this.level].upgrade_to;
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.BUZZSAW_LEVEL_5,1);
         super.tower_placed();
      }
   }
}

