package entities.towers.fire
{
   import entities.FlameThrower2;
   import net.flashpunk.graphics.Image;
   
   public class FireTower3 extends FireTower
   {
      
      public function FireTower3()
      {
         super(5,27);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["fire"][3]);
         this.level = 3;
         this.name = Towers.fire[this.level].name;
         this.range = Towers.fire[this.level].range;
         this.speed = Towers.fire[this.level].speed;
         this.damage = Towers.fire[this.level].damage;
         this.flame_damage = Towers.fire[this.level].flame_damage;
         this.flame_duration = Towers.fire[this.level].flame_duration;
         this.cost = Towers.fire[this.level].cost;
         this.upgrade_cost = Towers.fire[this.level].upgrade_cost;
         this.upgrade_to = Towers.fire[this.level].upgrade_to;
         this.flamethrower = new FlameThrower2(this,this.level);
      }
   }
}

