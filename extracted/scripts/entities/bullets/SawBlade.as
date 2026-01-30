package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import entities.effects.Effect;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   
   public class SawBlade extends Bullet
   {
      
      private static var pool:Array = new Array();
      
      private var _startDir:Number = 0;
      
      private var _range:Number = 0;
      
      private var _start_x:Number = 0;
      
      private var _start_y:Number = 0;
      
      private var _hit_timer:Number = 0;
      
      private var _hit_count:Number = 0;
      
      private var _zombies_hit:Array = new Array();
      
      public function SawBlade()
      {
         super();
         this.layer = Const.BULLET_LAYER;
      }
      
      public static function create(source:Class, tower:TowerEntity, x:Number, y:Number) : Bullet
      {
         var i:int = 0;
         if(pool.length == 0)
         {
            for(i = 0; i < 5; i++)
            {
               pool[i] = new SawBlade();
            }
         }
         var b:SawBlade = pool.splice(0,1)[0];
         b.setup(source,tower,x,y,null,true,null);
         return b;
      }
      
      override public function recycle() : void
      {
         if(this._active)
         {
            this._active = false;
            FP.world.remove(this);
            SawBlade.pool.push(this);
         }
      }
      
      override protected function cleanup() : void
      {
         if(this._active == false)
         {
            this._zombies_hit = null;
         }
         super.cleanup();
      }
      
      override public function setup(source:Class, tower:TowerEntity, x:Number, y:Number, e:Effect = null, causesHit:Boolean = true, clipRect:Rectangle = null) : void
      {
         super.setup(source,tower,x,y,e,causesHit,clipRect);
         this._start_x = x;
         this._start_y = y;
         this._startDir = Math.atan2(this.target.centerY - this.centerY,this.target.centerX - this.centerX);
         this._range = tower.range;
         this._hit_count = 0;
         this._hit_timer = 0;
         this._zombies_hit = new Array();
      }
      
      override public function update() : void
      {
         super.update();
         if(this._active)
         {
            this._hit_timer += FP.elapsed * Globals.speed;
            if(distance(this._start_x,this._start_y) > this._range)
            {
               this.recycle();
            }
         }
      }
      
      override protected function checkHit() : void
      {
         var zombies:Array = null;
         var z:ZombieEntity = null;
         if(this._hit_timer > 0.1)
         {
            this._hit_timer = 0;
            if(this.tower.air)
            {
               zombies = Globals.zombies.getZombies(this.tower.centerX,this.tower.centerY,this.tower.range);
            }
            else
            {
               zombies = Globals.zombies.getGround(this.tower.centerX,this.tower.centerY,this.tower.range);
            }
            for each(z in zombies)
            {
               if(!this.alreadyHit(z))
               {
                  if(distance(z.centerX,z.centerY) - 20 <= this.speed * Globals.speed)
                  {
                     ++this._hit_count;
                     this._zombies_hit.push(z);
                     z.hit(this.damage / this._hit_count,this.tower,true);
                     if(this._hit_count > 8)
                     {
                        this.recycle();
                        return;
                     }
                  }
               }
            }
         }
      }
      
      private function alreadyHit(zombie:ZombieEntity) : Boolean
      {
         var z:ZombieEntity = null;
         for each(z in this._zombies_hit)
         {
            if(z == zombie)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function checkTarget() : void
      {
      }
      
      override protected function updateAngle(dir:Number) : void
      {
         this.image.angle -= 15;
      }
      
      override protected function move(dir:Number) : void
      {
         this.x += Math.cos(this._startDir) * speed;
         this.y += Math.sin(this._startDir) * speed;
      }
      
      override public function hitTarget() : void
      {
      }
   }
}

