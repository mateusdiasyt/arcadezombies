package entities.towers.rapid
{
   import net.flashpunk.graphics.Image;
   
   public class RapidTower3 extends RapidTower
   {
      
      public function RapidTower3()
      {
         super(7,37);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["rapid"][3]);
         this.level = 3;
         this.name = Towers.rapid[this.level].name;
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
         muzzle_flash.x = -15;
         muzzle_flash.y = 9;
         muzzle_flash.originX = 30;
         muzzle_flash.originY = 6;
      }
   }
}

