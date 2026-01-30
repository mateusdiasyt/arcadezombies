package entities.towers.fire
{
   import entities.FlameThrower2;
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import entities.effects.Effect;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class FireTower extends TowerEntity
   {
      
      protected var flamethrower:FlameThrower2;
      
      private var flameTimer:Number = 0;
      
      protected var effect_rank:Number = 0;
      
      public function FireTower(base:int = 5, level:int = 25)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["fire"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["fire"][1]);
         this.muzzle_flash = null;
         this.causes_hit = false;
         this.level = 1;
         this.tower_type = "fire";
         this.name = Towers.fire[this.level].name;
         this.damage_display = Towers.fire[this.level].damage_display;
         this.range_display = Towers.fire[this.level].range_display;
         this.speed_display = Towers.fire[this.level].speed_display;
         this.effect_display = Towers.fire[this.level].effect_display;
         this.portrait_index = Towers.fire[this.level].portrait_index;
         this.ground = Towers.fire[this.level].ground;
         this.air = Towers.fire[this.level].air;
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
      
      override public function removed() : void
      {
         FP.world.remove(this.flamethrower);
         SoundManager.stopLoopingSound("flame" + getUID());
         super.removed();
      }
      
      override protected function tower_placed() : void
      {
         this.flamethrower.x = this.x;
         this.flamethrower.y = this.y;
         FP.world.add(this.flamethrower);
      }
      
      override public function update() : void
      {
         var zombies:Array = null;
         var z:ZombieEntity = null;
         this.flameTimer += FP.elapsed;
         super.update();
         this.flamethrower.image.angle = this.turret.angle;
         if(target != null)
         {
            this.flamethrower.show();
            if(this.flameTimer > 1 / this.speed)
            {
               this.flameTimer = 0;
               zombies = this.flamethrower.getHit();
               for each(z in zombies)
               {
                  z.hit(this.damage,this,this.causes_hit,true);
                  z.addEffect(new Effect(Effect.FIRE,this,this.effect_rank,flame_damage,flame_duration,0,false,true));
               }
            }
         }
         else
         {
            this.flamethrower.hide();
            SoundManager.stopLoopingSound("flame" + getUID());
         }
      }
      
      override protected function shoot() : void
      {
         if(!SoundManager.isPlaying("flame" + getUID()))
         {
            SoundManager.loopSound("flame" + getUID(),Assets.SFX_FLAME);
         }
      }
   }
}

