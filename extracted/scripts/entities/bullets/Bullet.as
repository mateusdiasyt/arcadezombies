package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import entities.effects.Effect;
   import flash.geom.Rectangle;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class Bullet extends Entity
   {
      
      private static var pool:Array = new Array();
      
      public var target:ZombieEntity = null;
      
      public var damage:Number = 0;
      
      public var speed:Number = 1;
      
      public var image:Image;
      
      public var doRotate:Boolean = true;
      
      public var causesHit:Boolean = true;
      
      public var effect:Effect = null;
      
      protected var tower:TowerEntity = null;
      
      protected var _active:Boolean = false;
      
      public function Bullet()
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
               pool[i] = new Bullet();
            }
         }
         var b:Bullet = pool.splice(0,1)[0];
         b.setup(source,tower,x,y,e,causesHit,clipRect);
         return b;
      }
      
      public function setup(source:Class, tower:TowerEntity, x:Number, y:Number, e:Effect = null, causesHit:Boolean = true, clipRect:Rectangle = null) : void
      {
         this._active = true;
         this.x = x;
         this.y = y;
         this.tower = tower;
         this.image = new Image(source,clipRect);
         this.image.x = -this.image.width / 2;
         this.image.y = -this.image.height / 2;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.graphic = this.image;
         this.speed = tower.bullet_speed;
         this.damage = tower.damage;
         this.target = tower.target;
         this.effect = e;
         this.doRotate = this.doRotate;
         this.causesHit = causesHit;
      }
      
      public function recycle() : void
      {
         if(this._active)
         {
            this._active = false;
            FP.world.remove(this);
            Bullet.pool.push(this);
         }
      }
      
      protected function cleanup() : void
      {
         if(this._active == false)
         {
            this.target = null;
            this.tower = null;
         }
      }
      
      override public function update() : void
      {
         var dir:Number = NaN;
         if(this._active)
         {
            this.checkTarget();
            dir = this.getDir();
            this.move(dir);
            this.updateAngle(dir);
            this.checkHit();
         }
         this.cleanup();
         super.update();
      }
      
      protected function getDir() : Number
      {
         return Math.atan2(this.target.centerY - this.centerY,this.target.centerX - this.centerX);
      }
      
      protected function checkHit() : void
      {
         if(this.distance(this.target.centerX,this.target.centerY) - 10 <= this.speed * Globals.speed * 60 * FP.elapsed)
         {
            this.hitTarget();
         }
      }
      
      protected function checkTarget() : void
      {
         if(this.target == null || this.target.dead)
         {
            this.recycle();
         }
      }
      
      protected function move(dir:Number) : void
      {
         this.x += Math.cos(dir) * this.speed * (60 * FP.elapsed) * Globals.speed;
         this.y += Math.sin(dir) * this.speed * (60 * FP.elapsed) * Globals.speed;
      }
      
      protected function updateAngle(dir:Number) : void
      {
         this.image.angle = -dir * 180 / Math.PI;
      }
      
      public function hitTarget() : void
      {
         this.target.hit(this.damage,this.tower,this.causesHit);
         if(Boolean(this.effect))
         {
            this.target.addEffect(this.effect);
         }
         this.afterHit();
         this.recycle();
      }
      
      public function afterHit() : void
      {
      }
      
      protected function distance(tx:Number, ty:Number) : Number
      {
         var dx:Number = this.centerX - tx;
         var dy:Number = this.centerY - ty;
         return Math.sqrt(dx * dx + dy * dy);
      }
   }
}

