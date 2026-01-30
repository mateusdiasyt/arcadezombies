package entities.buttons
{
   import entities.Button;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Stamp;
   import worlds.StartWorld;
   
   public class ImageButton extends Button
   {
      
      private var _normal:Stamp;
      
      private var _over:Stamp;
      
      private var callback:Function = null;
      
      private var hover:Function = null;
      
      private var hover_out:Function = null;
      
      private var hover_music:Class = null;
      
      public var suppressed:Boolean = true;
      
      public function ImageButton(x:Number, y:Number, w:Number, h:Number, normal:Class, over:Class, callback:Function, hover:Function = null, hover_out:Function = null, hover_music:Class = null)
      {
         super();
         this.x = x;
         this.y = y;
         this.callback = callback;
         this.hover = hover;
         this.hover_out = hover_out;
         this.hover_music = hover_music;
         this._normal = new Stamp(normal);
         this._over = new Stamp(over);
         this.graphic = this._normal;
         this.setHitbox(w,h);
      }
      
      public function reset() : void
      {
         this.graphic = this._normal;
         this.hovering = false;
      }
      
      override public function clickAction() : void
      {
         if(this.callback != null)
         {
            this.callback();
            try
            {
               (FP.world as StartWorld).suppressAll();
            }
            catch(e:Error)
            {
            }
            this.graphic = this._normal;
         }
      }
      
      override public function mouseOver() : void
      {
         if(this.hover != null)
         {
            this.hover();
         }
         if(this.hover_music != null && !this.suppressed)
         {
            SoundManager.playSound(this.hover_music);
         }
         this.graphic = this._over;
      }
      
      override public function mouseOut() : void
      {
         if(this.hover_out != null)
         {
            this.hover_out();
         }
         this.graphic = this._normal;
      }
      
      override public function update() : void
      {
         super.update();
      }
   }
}

