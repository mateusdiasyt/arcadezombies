package entities.towers.buzzsaw
{
   import net.flashpunk.graphics.Image;
   
   public class BuzzsawTower4 extends BuzzsawTower
   {
      
      public function BuzzsawTower4()
      {
         super(6,33);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw"][4]);
         this.reload = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw_reload"][4]);
         this.level = 4;
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

