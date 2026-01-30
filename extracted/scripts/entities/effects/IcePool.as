package entities.effects
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   
   public class IcePool extends Entity
   {
      
      private var _zombies:Array = new Array();
      
      private var _timer:Number = 0;
      
      private var _duration:Number = 0.25;
      
      private var _range:Number = 0.25;
      
      private var _effect:Effect;
      
      private var _damage:Number;
      
      private var _tower:TowerEntity;
      
      private var _active:Boolean = true;
      
      public function IcePool(x:Number, y:Number, r:Number, e:Effect, damage:Number, tower:TowerEntity, d:Number = 0.25)
      {
         super();
         this._duration = d;
         this._range = r;
         this._effect = e;
         this._damage = damage;
         this._tower = tower;
         this.x = x;
         this.y = y;
      }
      
      override public function update() : void
      {
         var range:Number = NaN;
         var zombies:Array = null;
         var z:ZombieEntity = null;
         if(this._active)
         {
            this._timer += FP.elapsed;
            range = this._range * (this._timer / this._duration);
            zombies = Globals.zombies.getZombies(this.x,this.y,range,true);
            for each(z in zombies)
            {
               if(!this.alreadyFrozen(z))
               {
                  this._zombies.push(z);
                  z.hit(this._damage,this._tower,false);
                  z.addEffect(this._effect);
               }
            }
            if(this._timer > this._duration)
            {
               this._active = false;
               FP.world.remove(this);
            }
         }
      }
      
      private function alreadyFrozen(z:ZombieEntity) : Boolean
      {
         var zombie:ZombieEntity = null;
         for each(zombie in this._zombies)
         {
            if(z == zombie)
            {
               return true;
            }
         }
         return false;
      }
   }
}

