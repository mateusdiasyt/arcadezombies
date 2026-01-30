package entities.bullets
{
   import entities.TowerEntity;
   import entities.effects.Effect;
   import entities.effects.IcePool;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   
   public class IceBall extends Bullet
   {
      
      private static var pool:Array = new Array();
      
      protected var splash_damage:Number;
      
      protected var splash_range:Number;
      
      public function IceBall()
      {
         super();
         this.layer = Const.BULLET_LAYER;
      }
      
      public static function create(source:Class, tower:TowerEntity, x:Number, y:Number, e:Effect = null, doRotate:Boolean = true, causesHit:Boolean = true, clipRect:Rectangle = null) : Bullet
      {
         var i:int = 0;
         if(pool.length == 0)
         {
            for(i = 0; i < 5; i++)
            {
               pool[i] = new IceBall();
            }
         }
         var b:IceBall = pool.splice(0,1)[0];
         b.setup(source,tower,x,y,e,causesHit,clipRect);
         return b;
      }
      
      override public function recycle() : void
      {
         if(_active)
         {
            this._active = false;
            FP.world.remove(this);
            IceBall.pool.push(this);
         }
      }
      
      override public function setup(source:Class, tower:TowerEntity, x:Number, y:Number, e:Effect = null, causesHit:Boolean = true, clipRect:Rectangle = null) : void
      {
         super.setup(source,tower,x,y,e,causesHit,null);
         this.splash_damage = tower.splash_damage;
         this.splash_range = tower.splash_range;
      }
      
      override public function afterHit() : void
      {
         Globals.effects.emitSnow(this.target.centerX,this.target.centerY,this.splash_range);
         FP.world.add(new IcePool(this.target.centerX,this.target.centerY,this.splash_range,this.effect,this.splash_damage,this.tower));
      }
   }
}

