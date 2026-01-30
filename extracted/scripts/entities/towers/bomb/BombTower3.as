package entities.towers.bomb
{
   import entities.bullets.Bomb;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class BombTower3 extends BombTower
   {
      
      public function BombTower3()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["bomb"][3]);
         this.name = Towers.bomb[3].name;
         this.level = 3;
         this.ground = Towers.bomb[3].ground;
         this.air = Towers.bomb[3].air;
         this.range = Towers.bomb[3].range;
         this.speed = Towers.bomb[3].speed;
         this.damage = Towers.bomb[3].damage;
         this.bullet_speed = Towers.bomb[3].bullet_speed;
         this.splash_damage = Towers.bomb[3].splash_damage;
         this.splash_range = Towers.bomb[3].splash_range;
         this.cost = Towers.bomb[3].cost;
         this.damage_text = this.damage + "*";
         this.upgrade_cost = Towers.bomb[3].upgrade_cost;
         this.upgrade_to = Towers.bomb[3].upgrade_to;
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_BOMB);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 10;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 10;
         Globals.effects.emitSmoke(this.centerX - 15 - Math.cos(-this.turret.angle * Math.PI / 180) * 14,this.centerY - 15 - Math.sin(-this.turret.angle * Math.PI / 180) * 14,"bomb");
         FP.world.add(Bomb.create(this.bullet,this,bx,by));
      }
   }
}

