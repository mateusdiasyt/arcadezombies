package entities.towers.bomb
{
   import entities.bullets.Bomb;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class BombTower2 extends BombTower
   {
      
      public function BombTower2()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["bomb"][2]);
         this.level = 2;
         this.name = Towers.bomb[this.level].name;
         this.ground = Towers.bomb[this.level].ground;
         this.air = Towers.bomb[this.level].air;
         this.range = Towers.bomb[this.level].range;
         this.speed = Towers.bomb[this.level].speed;
         this.damage = Towers.bomb[this.level].damage;
         this.bullet_speed = Towers.bomb[this.level].bullet_speed;
         this.splash_damage = Towers.bomb[this.level].splash_damage;
         this.splash_range = Towers.bomb[this.level].splash_range;
         this.cost = Towers.bomb[this.level].cost;
         this.damage_text = this.damage + "*";
         this.upgrade_cost = Towers.bomb[this.level].upgrade_cost;
         this.upgrade_to = Towers.bomb[this.level].upgrade_to;
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_BOMB);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 8;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 8;
         Globals.effects.emitSmoke(this.centerX - 15 - Math.cos(-this.turret.angle * Math.PI / 180) * 12,this.centerY - 15 - Math.sin(-this.turret.angle * Math.PI / 180) * 12,"bomb");
         FP.world.add(Bomb.create(this.bullet,this,bx,by));
      }
   }
}

