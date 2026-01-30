package entities.buttons
{
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.utils.Input;
   
   public class SoundDial extends Entity
   {
      
      private var _knob:Image = new Image(Assets.GFX_KNOB);
      
      private var _dial:Image = new Image(Assets.GFX_DIAL);
      
      private var _turning:Boolean = false;
      
      private var _turning_x:Number = 0;
      
      private var _percent:Number = 0;
      
      private var _enabled:Boolean = true;
      
      public function SoundDial()
      {
         super();
         this._knob.x = 32;
         this._knob.y = 35;
         this._knob.originX = -2;
         this._knob.originY = -2;
         this.setHitbox(71,63);
         this.graphic = new Graphiclist(this._dial,this._knob);
      }
      
      public function setValue(n:Number) : void
      {
         this._percent = n;
      }
      
      public function getValue() : Number
      {
         return this._percent;
      }
      
      public function enable() : void
      {
         this._enabled = true;
         this._knob.alpha = 1;
         this._dial.alpha = 1;
      }
      
      public function disable() : void
      {
         this._enabled = false;
         this._knob.alpha = 0.3;
         this._dial.alpha = 0.3;
      }
      
      override public function update() : void
      {
         var range:Number = NaN;
         if(this._enabled)
         {
            if(Input.mousePressed && collidePoint(this.x,this.y,Input.mouseX,Input.mouseY) && !this._turning)
            {
               this._turning = true;
               this._turning_x = Input.mouseX;
            }
            if(this._turning)
            {
               range = Input.mouseX - this._turning_x;
               if(range < -1 && this._percent > 0)
               {
                  if(range < -1 && range > -20)
                  {
                     this._percent -= 0.0025;
                  }
                  else if(range <= -20 && range > -40)
                  {
                     this._percent -= 0.02;
                  }
                  else
                  {
                     this._percent -= 0.04;
                  }
               }
               else if(range > 1 && this._percent < 1)
               {
                  if(range > 1 && range < 20)
                  {
                     this._percent += 0.0025;
                  }
                  else if(range >= 20 && range <= 40)
                  {
                     this._percent += 0.02;
                  }
                  else
                  {
                     this._percent += 0.04;
                  }
               }
            }
            if(Input.mouseUp)
            {
               this._turning = false;
            }
         }
         var angle:Number = this._percent * 170 + 180;
         var rad:Number = angle * Math.PI / 180;
         this._knob.x = 32 + Math.cos(rad) * 10;
         this._knob.y = 35 + Math.sin(rad) * 10;
         super.update();
      }
   }
}

