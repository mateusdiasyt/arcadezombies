package entities.towers.bomb
{
   import entities.bullets.Bomb;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class BombTower4 extends BombTower
   {
      
      public function BombTower4()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["bomb"][4]);
         this.name = Towers.bomb[4].name;
         this.level = 4;
         this.ground = Towers.bomb[4].ground;
         this.air = Towers.bomb[4].air;
         this.range = Towers.bomb[4].range;
         this.speed = Towers.bomb[4].speed;
         this.damage = Towers.bomb[4].damage;
         this.bullet_speed = Towers.bomb[4].bullet_speed;
         this.splash_damage = Towers.bomb[4].splash_damage;
         this.splash_range = Towers.bomb[4].splash_range;
         this.cost = Towers.bomb[4].cost;
         this.damage_text = this.damage + "*";
         this.upgrade_cost = Towers.bomb[4].upgrade_cost;
         this.upgrade_to = Towers.bomb[4].upgrade_to;
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_BOMB);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 12;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 12;
         Globals.effects.emitSmoke(this.centerX - 15 - Math.cos(-this.turret.angle * Math.PI / 180) * 16,this.centerY - 15 - Math.sin(-this.turret.angle * Math.PI / 180) * 16,"bomb");
         FP.world.add(Bomb.create(this.bullet,this,bx,by));
      }
   }
}

