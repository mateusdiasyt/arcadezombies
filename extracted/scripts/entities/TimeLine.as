package entities
{
   import entities.buttons.ZombieTimeLine;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   
   public class TimeLine extends Container
   {
      
      private static var DISTANCE:Number = 50;
      
      private static var MOVEMENT:Number = 1;
      
      private var timer:Number = 0;
      
      private var interval:Number = 0.25;
      
      private var remainder:Number = 0;
      
      private var already_scrolled:Number = 0;
      
      private var wave_added:Number = 0;
      
      public function TimeLine()
      {
         super();
         this.removeable = false;
         var between_spawns:Number = Globals.spawns.level.between_levels;
         this.interval = between_spawns / (DISTANCE / MOVEMENT);
      }
      
      override public function added() : void
      {
         var waves:Array = Globals.spawns.level.waves;
         this.wave_added = 2;
         add(new ZombieTimeLine(waves[0],this.x,0),DISTANCE,5);
         add(new ZombieTimeLine(waves[1],this.x,1),2 * DISTANCE,5);
         add(new ZombieTimeLine(waves[2],this.x,2),3 * DISTANCE,5);
         super.added();
      }
      
      public function reset() : void
      {
         this.removeAll();
      }
      
      public function callNextLevel(force_call:Boolean = false) : void
      {
         var z:ZombieTimeLine = null;
         for(var i:int = 0; i < children.length; i++)
         {
            if(children[i].x - this.x > 0)
            {
               z = children[i] as ZombieTimeLine;
               if(z.callable || force_call)
               {
                  z.callLevel();
               }
               return;
            }
         }
      }
      
      public function scrollTo(level:int) : void
      {
         var z:ZombieTimeLine = null;
         var level_loc:Number = NaN;
         var scroll_amount:Number = NaN;
         var c:Entity = null;
         var score:Number = NaN;
         for each(z in children)
         {
            if(z.level == level)
            {
               break;
            }
         }
         level_loc = z.x;
         scroll_amount = level_loc - this.x;
         if(Globals.score.level != 0)
         {
            score = (scroll_amount + 1) * 2;
            Globals.score.score += score;
            FP.world.add(ValuePopEntity.create(score,this.x + 30,this.y + 10,3394815));
         }
         for each(c in children)
         {
            c.x -= scroll_amount;
         }
         this.already_scrolled += scroll_amount;
      }
      
      override public function update() : void
      {
         var c:Entity = null;
         var waves:Array = null;
         var wave_offset:Number = NaN;
         var button:ZombieTimeLine = null;
         this.timer += FP.elapsed * Globals.speed;
         if(this.timer >= this.interval)
         {
            this.remainder += this.timer - this.interval;
            this.timer = 0;
            for each(c in children)
            {
               c.x -= MOVEMENT;
            }
            this.already_scrolled += MOVEMENT;
            if(this.remainder >= this.interval)
            {
               this.remainder -= this.interval;
               for each(c in children)
               {
                  c.x -= MOVEMENT;
               }
               this.already_scrolled += MOVEMENT;
            }
         }
         if(children.length > 0 && children[0].x < this.x - 50)
         {
            remove(children[0]);
         }
         if(children.length > 0 && children[children.length - 1].x < this.x + 130)
         {
            ++this.wave_added;
            waves = Globals.spawns.level.waves;
            wave_offset = Globals.spawns.level.max_level - Globals.spawns.level.waves.length;
            if(this.wave_added - wave_offset < waves.length)
            {
               button = new ZombieTimeLine(waves[this.wave_added - wave_offset],this.x,this.wave_added);
               add(button,children[children.length - 1].x - this.x + 50,5);
            }
         }
      }
      
      override public function render() : void
      {
         var c:Entity = null;
         var bitmapdata:BitmapData = new BitmapData(130,40,true,0);
         for each(c in children)
         {
            FP.point.x = c.x - this.x;
            FP.point.y = c.y - this.y;
            c.graphic.render(bitmapdata,FP.point,FP.zero);
         }
         FP.buffer.copyPixels(bitmapdata,new Rectangle(0,0,130,40),new Point(this.x,this.y));
         super.render();
      }
   }
}

