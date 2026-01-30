package entities.effects
{
   import entities.ZombieEntity;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Emitter;
   
   public class Flame extends Entity
   {
      
      private var _target:ZombieEntity;
      
      private var _duration:Number;
      
      private var _timer:Number = 0;
      
      private var _flame_timer:Number = 0;
      
      private var _burn:Emitter;
      
      public function Flame(target:ZombieEntity, duration:Number)
      {
         super();
         this.layer = Const.EFFECTS_LAYER;
         this._target = target;
         this._duration = duration;
         this.x = this._target.centerX - 6;
         this.y = this._target.centerY - 15;
         this._burn = new Emitter(Assets.GFX_BURN,12,21);
         this._burn.newType("burn",[0,1,2,3,4]);
         this._burn.setMotion("burn",0,0,0.25,365,10,0.25);
         this.graphic = this._burn;
      }
      
      public function refresh(d:Number) : void
      {
         if(this._duration < d)
         {
            this._duration = d;
         }
         this._timer = 0;
      }
      
      override public function update() : void
      {
         this._timer += FP.elapsed;
         this._flame_timer += FP.elapsed;
         if(this._timer > this._duration)
         {
            this._target.removeFlame();
         }
         if(this._flame_timer > 0.15)
         {
            this._flame_timer = 0;
            this._burn.emit("burn",Globals.randRange(-10,10),Globals.randRange(-10,10));
         }
         this.x = this._target.centerX - 6;
         this.y = this._target.centerY - 15;
         if(this._target == null || this._target.dead)
         {
            FP.world.remove(this);
         }
      }
   }
}

