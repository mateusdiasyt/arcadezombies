package entities.towers.bomb
{
   import entities.TowerEntity;
   import entities.bullets.Bomb;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class BombTower extends TowerEntity
   {
      
      public function BombTower()
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["bomb"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["bomb"][1]);
         this.bullet = Assets.GFX_BOMB;
         this.muzzle_flash = null;
         this.level = 1;
         this.tower_type = "bomb";
         this.name = Towers.bomb[this.level].name;
         this.damage_display = Towers.bomb[this.level].damage_display;
         this.range_display = Towers.bomb[this.level].range_display;
         this.speed_display = Towers.bomb[this.level].speed_display;
         this.effect_display = Towers.bomb[this.level].effect_display;
         this.portrait_index = Towers.bomb[this.level].portrait_index;
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
      
      override public function added() : void
      {
         super.added();
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_BOMB);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 6;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 6;
         Globals.effects.emitSmoke(this.centerX - 15 - Math.cos(-this.turret.angle * Math.PI / 180) * 10,this.centerY - 15 - Math.sin(-this.turret.angle * Math.PI / 180) * 10,"bomb");
         FP.world.add(Bomb.create(this.bullet,this,bx,by));
      }
   }
}

