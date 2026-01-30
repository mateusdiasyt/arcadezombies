package entities.buttons
{
   import achievements.Tracker;
   import entities.Button;
   import entities.ZombieEntity;
   import entities.menu.TimeLineMenuHover;
   import levels.Wave;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.utils.Input;
   
   public class ZombieTimeLine extends Button
   {
      
      private var start_x:Number = 0;
      
      public var level:Number = 0;
      
      private var wave_name:String = "";
      
      private var portrait:Spritemap = new Spritemap(Assets.GFX_ZOMBIE_PORTRAITS,30,30);
      
      private var target:ZombieEntity;
      
      private var count:Number;
      
      private var hoverMenu:TimeLineMenuHover;
      
      private var _callable:Boolean = false;
      
      private var _flash_timer:Number = 0;
      
      public function ZombieTimeLine(wave:Wave, start_x:Number, level:int)
      {
         super();
         this.start_x = start_x;
         this.level = level;
         this.count = wave.count;
         var e:Number = wave.portrait_index;
         this.wave_name = wave.wave_name;
         var d:Number = e + 1;
         var c:Number = e + 2;
         this.portrait.add("available",[e]);
         this.portrait.add("launched",[d]);
         this.portrait.add("not available",[c]);
         this.portrait.add("spawning",[e,d,c,d],5);
         this.portrait.play("enabled");
         this.graphic = this.portrait;
         this.setHitbox(30,30);
      }
      
      override public function removed() : void
      {
         this.target = null;
         if(Boolean(this.hoverMenu))
         {
            FP.world.remove(this.hoverMenu);
         }
         this.hoverMenu = null;
         this.portrait = null;
         super.removed();
      }
      
      override public function render() : void
      {
      }
      
      override public function clickAction() : void
      {
         if(this.callable)
         {
            this.callLevel();
         }
      }
      
      public function get callable() : Boolean
      {
         return this._callable;
      }
      
      override public function update() : void
      {
         if(this.level == Globals.score.level && Globals.spawns.doneSpawning())
         {
            this._callable = true;
            this.portrait.play("available");
         }
         else if(Globals.score.level <= this.level)
         {
            this._callable = false;
            this.portrait.play("not available");
         }
         else if(Globals.score.level == this.level + 1 && !Globals.spawns.doneSpawning() && this._flash_timer < 3)
         {
            this._flash_timer += FP.elapsed;
            this._callable = false;
            this.portrait.play("spawning");
         }
         else
         {
            this._callable = false;
            this.portrait.play("launched");
         }
         super.update();
      }
      
      public function callLevel() : void
      {
         if(Globals.score.level != 0)
         {
            Globals.spawns.level.waves[0].called_early = 2;
         }
         Globals.timeline.scrollTo(this.level);
         Globals.spawns.spawnTo(this.level);
         Globals.tracker.incrementData(Tracker.EARLY_WAVE,this.level - Globals.score.level + 1);
      }
      
      override public function mouseOver() : void
      {
         if(Input.mouseX >= 488 && Input.mouseY <= 630)
         {
            FP.world.add(this.hoverMenu = new TimeLineMenuHover(this.wave_name,this.count));
         }
      }
      
      override public function mouseOut() : void
      {
         if(Boolean(this.hoverMenu))
         {
            FP.world.remove(this.hoverMenu);
         }
      }
      
      override protected function hidden() : Boolean
      {
         if(this.x < this.start_x + 150 && this.x > this.start_x)
         {
            return false;
         }
         return true;
      }
   }
}

