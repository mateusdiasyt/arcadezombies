package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import net.flashpunk.FP;
   
   public class SuperMissile extends Missile
   {
      
      private static var pool:Array = new Array();
      
      public function SuperMissile()
      {
         super();
      }
      
      public static function create(source:Class, tower:TowerEntity, x:Number, y:Number, target:ZombieEntity) : Bullet
      {
         var b:SuperMissile = null;
         var i:int = 0;
         if(pool.length == 0)
         {
            for(i = 0; i < 11; i++)
            {
               pool[i] = new SuperMissile();
            }
         }
         b = pool.splice(0,1)[0];
         b.setup(source,tower,x,y,null,true,null);
         b.target = target;
         b.ground_missile = false;
         b.damage *= 3;
         return b;
      }
      
      override public function recycle() : void
      {
         if(_active)
         {
            _active = false;
            FP.world.remove(this);
            SuperMissile.pool.push(this);
         }
      }
      
      override public function afterHit() : void
      {
         Globals.effects.emitMissile(this.centerX,this.centerY,true);
         SoundManager.playSound(Assets.SFX_EXPLODE);
      }
   }
}

