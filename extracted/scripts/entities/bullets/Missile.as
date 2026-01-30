package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import entities.effects.Effect;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class Missile extends Bullet
   {
      
      private static var pool:Array = new Array();
      
      private var max_speed:Number = 6;
      
      private var acc_x:Number = 0;
      
      private var acc_y:Number = 0;
      
      private var speed_x:Number = 0;
      
      private var speed_y:Number = 0;
      
      private var timer:Number = 0;
      
      private var delay:Number = 0;
      
      private var showing:Boolean = false;
      
      private var flash_start:Number = 0;
      
      private var flash_end:Number = 0;
      
      private var flash_showing:Boolean = false;
      
      private var flash_image:Image = new Image(Assets.GFX_MISSILE_FLASH);
      
      protected var ground_missile:Boolean = false;
      
      public function Missile()
      {
         super();
         this.layer = Const.BULLET_LAYER;
      }
      
      public static function create(source:Class, tower:TowerEntity, x:Number, y:Number, target:ZombieEntity) : Bullet
      {
         var i:int = 0;
         if(pool.length == 0)
         {
            for(i = 0; i < 11; i++)
            {
               pool[i] = new Missile();
            }
         }
         var b:Missile = pool.splice(0,1)[0];
         b.setup(source,tower,x,y,null,true,null);
         b.target = target;
         b.ground_missile = !target.flying;
         return b;
      }
      
      override public function recycle() : void
      {
         if(_active)
         {
            _active = false;
            FP.world.remove(this);
            Missile.pool.push(this);
         }
      }
      
      override public function setup(source:Class, tower:TowerEntity, x:Number, y:Number, e:Effect = null, causesHit:Boolean = true, clipRect:Rectangle = null) : void
      {
         super.setup(source,tower,x,y,e,true,null);
         this.acc_x = 0;
         this.acc_y = 0;
         this.timer = 0;
         this.delay = 0;
         this.showing = false;
         this.flash_start = 0;
         this.flash_end = 0;
         this.flash_showing = false;
         var dir:Number = Math.atan2(tower.target.centerY - this.centerY,tower.target.centerX - this.centerX);
         this.speed_x = Math.cos(dir) * 2;
         this.speed_y = Math.sin(dir) * 2;
         this.graphic = null;
         this.flash_image.x = -3.5;
         this.flash_image.y = -3.5;
         this.delay = 0.25 + Math.random() / 4;
         this.flash_start = this.delay - 0.25;
         this.flash_end = this.delay - 0.15;
      }
      
      override protected function checkTarget() : void
      {
         var ground:Array = null;
         var air:Array = null;
         if(target == null || target.dead)
         {
            if(this.ground_missile)
            {
               ground = Globals.zombies.getGround(this.centerX,this.centerY,1000);
               if(ground.length == 0)
               {
                  ground = Globals.zombies.getGround(this.tower.centerX,this.tower.centerY,this.tower.range);
               }
               if(ground.length > 0)
               {
                  target = ground[0];
               }
            }
            else
            {
               air = Globals.zombies.getFlying(this.centerX,this.centerY,1000);
               if(air.length == 0)
               {
                  air = Globals.zombies.getFlying(this.tower.centerX,this.tower.centerY,this.tower.range);
               }
               if(air.length > 0)
               {
                  target = air[0];
               }
            }
            if(target == null || target.dead)
            {
               this.recycle();
            }
         }
      }
      
      override protected function move(dir:Number) : void
      {
         var speed_adj:Number = NaN;
         this.timer += FP.elapsed * Globals.speed;
         if(!this.flash_showing && this.timer > this.flash_start)
         {
            this.flash_showing = true;
            this.graphic = this.flash_image;
         }
         else if(this.flash_showing && this.timer > this.flash_end && this.timer < this.delay)
         {
            this.graphic = null;
         }
         if(this.timer > this.delay)
         {
            speed_adj = Globals.speed * 60 * FP.elapsed;
            if(!this.showing)
            {
               this.showing = true;
               this.graphic = this.image;
            }
            this.acc_x = this.sgn(target.centerX - this.centerX) * this.engine() * speed_adj;
            this.acc_y = this.sgn(target.centerY - this.centerY) * this.engine() * speed_adj;
            this.speed_x = Math.min(this.max_speed * speed_adj,Math.abs(this.speed_x + this.acc_x)) * this.sgn(this.speed_x + this.acc_x) * this.drag();
            this.speed_y = Math.min(this.max_speed * speed_adj,Math.abs(this.speed_y + this.acc_y)) * this.sgn(this.speed_y + this.acc_y) * this.drag();
            this.x += this.speed_x;
            this.y += this.speed_y;
         }
      }
      
      override protected function updateAngle(dir:Number) : void
      {
         this.image.angle = -Math.atan2(this.speed_y,this.speed_x) * 180 / Math.PI;
      }
      
      private function engine() : Number
      {
         return Math.random() * 0.1 + 0.05;
      }
      
      private function drag() : Number
      {
         return Math.random() * 0.05 + 0.94;
      }
      
      private function sgn(n:Number) : int
      {
         return n < 0 ? -1 : 1;
      }
      
      override public function afterHit() : void
      {
         Globals.effects.emitMissile(this.centerX,this.centerY);
         SoundManager.playSound(Assets.SFX_SMALL_EXPLODE);
      }
   }
}

