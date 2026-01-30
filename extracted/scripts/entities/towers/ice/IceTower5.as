package entities.towers.ice
{
   import achievements.Tracker;
   import net.flashpunk.graphics.Image;
   
   public class IceTower5 extends IceTower
   {
      
      public function IceTower5()
      {
         super(4,24);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["ice"][5]);
         this.level = 5;
         this.name = Towers.ice[this.level].name;
         this.range = Towers.ice[this.level].range;
         this.speed = Towers.ice[this.level].speed;
         this.damage = Towers.ice[this.level].damage;
         this.bullet_speed = Towers.ice[this.level].bullet_speed;
         this.splash_damage = Towers.ice[this.level].splash_damage;
         this.splash_range = Towers.ice[this.level].splash_range;
         this.slow = Towers.ice[this.level].slow;
         this.slow_time = Towers.ice[this.level].slow_time;
         this.slow_rank = Towers.ice[this.level].slow_rank;
         this.cost = Towers.ice[this.level].cost;
         this.upgrade_cost = Towers.ice[this.level].upgrade_cost;
         this.upgrade_to = Towers.ice[this.level].upgrade_to;
         this.damage_text = this.damage + "*";
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.ICE_LEVEL_5,1);
         super.tower_placed();
      }
   }
}

