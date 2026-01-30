package entities.towers.buzzsaw
{
   import net.flashpunk.graphics.Image;
   
   public class BuzzsawTower3 extends BuzzsawTower
   {
      
      public function BuzzsawTower3()
      {
         super(6,32);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw"][3]);
         this.reload = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw_reload"][3]);
         this.level = 3;
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
   }
}

