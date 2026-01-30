package entities.bullets
{
   import entities.TowerEntity;
   import entities.effects.Effect;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   
   public class Bomb extends Bullet
   {
      
      private static var pool:Array = new Array();
      
      protected var splash_damage:Number;
      
      protected var splash_range:Number;
      
      protected var last_x:Number = 0;
      
      protected var last_y:Number = 0;
      
      public function Bomb()
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
               pool[i] = new Bomb();
            }
         }
         var b:Bomb = pool.splice(0,1)[0];
         b.setup(source,tower,x,y,e,causesHit,clipRect);
         return b;
      }
      
      override public function recycle() : void
      {
         if(this._active)
         {
            this._active = false;
            FP.world.remove(this);
            Bomb.pool.push(this);
         }
      }
      
      override protected function checkTarget() : void
      {
      }
      
      override public function update() : void
      {
         if(target != null && !target.dead)
         {
            this.last_x = this.target.centerX;
            this.last_y = this.target.centerY;
         }
         super.update();
      }
      
      override protected function checkHit() : void
      {
         if(distance(this.last_x,this.last_y) - 10 < this.speed * Globals.speed)
         {
            this.hitTarget();
         }
      }
      
      override public function hitTarget() : void
      {
         if(target != null && !target.dead)
         {
            this.target.hit(this.damage,this.tower,causesHit);
            if(Boolean(this.effect))
            {
               this.target.addEffect(this.effect);
            }
         }
         this.afterHit();
         this.recycle();
      }
      
      override public function setup(source:Class, tower:TowerEntity, x:Number, y:Number, e:Effect = null, causesHit:Boolean = true, clipRect:Rectangle = null) : void
      {
         super.setup(source,tower,x,y,e,causesHit,new Rectangle(14 * (tower.level - 1),0,14,14));
         this.splash_damage = tower.splash_damage;
         this.splash_range = tower.splash_range;
         this.last_x = this.target.centerX;
         this.last_y = this.target.centerY;
      }
      
      override public function afterHit() : void
      {
         var splash:SplashEntity = new SplashEntity(tower,this.last_x,this.last_y,this.splash_damage,this.splash_range);
         FP.world.add(splash);
      }
   }
}

