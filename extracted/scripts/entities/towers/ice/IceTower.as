package entities.towers.ice
{
   import entities.TowerEntity;
   import entities.bullets.IceBall;
   import entities.effects.Effect;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class IceTower extends TowerEntity
   {
      
      public function IceTower(base:int = 4, level:int = 20)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["ice"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["ice"][1]);
         this.bullet = Assets.GFX_SNOW_BALL;
         this.muzzle_flash = null;
         this.causes_hit = false;
         this.level = 1;
         this.tower_type = "ice";
         this.name = Towers.ice[this.level].name;
         this.damage_display = Towers.ice[this.level].diamage_display;
         this.range_display = Towers.ice[this.level].range_display;
         this.speed_display = Towers.ice[this.level].speed_display;
         this.effect_display = Towers.ice[this.level].effect_display;
         this.portrait_index = Towers.ice[this.level].portrait_index;
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
      
      override public function added() : void
      {
         super.added();
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_ICE);
         var bx:Number = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 10;
         var by:Number = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 10;
         var e:Effect = new Effect(Effect.ICE,this,this.slow_rank,0,this.slow_time,this.slow);
         FP.world.add(IceBall.create(this.bullet,this,bx,by,e));
      }
   }
}

