package entities.towers.bomb
{
   import achievements.Tracker;
   import entities.bullets.Bomb;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class BombTower5 extends BombTower
   {
      
      public function BombTower5()
      {
         super();
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["bomb"][5]);
         this.name = Towers.bomb[5].name;
         this.level = 5;
         this.ground = Towers.bomb[5].ground;
         this.air = Towers.bomb[5].air;
         this.range = Towers.bomb[5].range;
         this.speed = Towers.bomb[5].speed;
         this.damage = Towers.bomb[5].damage;
         this.bullet_speed = Towers.bomb[5].bullet_speed;
         this.splash_damage = Towers.bomb[5].splash_damage;
         this.splash_range = Towers.bomb[5].splash_range;
         this.cost = Towers.bomb[5].cost;
         this.damage_text = this.damage + "*";
         this.upgrade_cost = Towers.bomb[5].upgrade_cost;
         this.upgrade_to = Towers.bomb[5].upgrade_to;
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.BOMB_LEVEL_5,1);
         super.tower_placed();
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_BOMB);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 14;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 14;
         Globals.effects.emitSmoke(this.centerX - 15 - Math.cos(-this.turret.angle * Math.PI / 180) * 18,this.centerY - 15 - Math.sin(-this.turret.angle * Math.PI / 180) * 18,"bomb");
         FP.world.add(Bomb.create(this.bullet,this,bx,by));
      }
   }
}

