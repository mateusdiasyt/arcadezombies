package entities.effects
{
   import entities.ZombieEntity;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class SnowFlake extends Entity
   {
      
      private var _target:ZombieEntity;
      
      private var _duration:Number;
      
      private var _timer:Number = 0;
      
      private var _flake:Spritemap = new Spritemap(Assets.GFX_SNOW_FLAKE,13,13);
      
      public function SnowFlake(target:ZombieEntity, duration:Number)
      {
         super();
         this.layer = Const.EFFECTS_LAYER;
         this._target = target;
         this._duration = duration;
         this.x = this._target.centerX - 6;
         this.y = this._target.centerY - 7;
         this._flake.add("fall",[0,1,2,3,4,5],7);
         this._flake.play("fall");
         this.graphic = this._flake;
      }
      
      override public function update() : void
      {
         this._timer += FP.elapsed * Globals.speed;
         if(this._timer > this._duration)
         {
            this._target.removeFlake();
         }
         this.x = this._target.centerX - 6;
         this.y = this._target.centerY - 7;
         if(this._target == null || this._target.dead)
         {
            FP.world.remove(this);
         }
         super.update();
      }
      
      public function refresh(d:Number) : void
      {
         if(this._duration < d)
         {
            this._duration = d;
         }
         this._timer = 0;
      }
   }
}

