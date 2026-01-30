package entities
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   
   public class DelayTooltip extends Entity
   {
      
      private var _text:Text;
      
      private var _background:Image;
      
      private var _delay:Number = 0;
      
      private var _tooltip_x:Number = 0;
      
      private var _tooltip_y:Number = 0;
      
      private var _tooltip_w:Number = 0;
      
      private var _tooltip_h:Number = 0;
      
      private var _delay_timer:Number = 0;
      
      public function DelayTooltip(text:String, tx:Number, ty:Number, w:Number, h:Number, delay:Number = 1)
      {
         super();
         this.layer = Const.TOOLTIP_LAYER;
         this._delay = delay;
         this._tooltip_x = tx;
         this._tooltip_y = ty;
         this._tooltip_w = w;
         this._tooltip_h = h;
         this.setText(text);
         this.setHitbox(w,h);
      }
      
      public function setText(s:String) : void
      {
         Text.font = Const.FONT_TEXT;
         Text.size = 12 / Const.FONT_OFFSET;
         this._text = new Text(s);
         this._text.color = 0;
         this._background = null;
         this._background = this.getBackground();
         this._background.x = -4;
         this._background.y = this._tooltip_h + 1;
         this._text.x = -3;
         this._text.y = this._tooltip_h + 1;
      }
      
      override public function update() : void
      {
         if(collidePoint(this.x,this.y,Input.mouseX,Input.mouseY))
         {
            this._delay_timer += FP.elapsed;
            if(this._delay_timer > this._delay)
            {
               this.graphic = new Graphiclist(this._background,this._text);
            }
         }
         else
         {
            this._delay_timer = 0;
            this.graphic = null;
         }
         super.update();
      }
      
      override public function removed() : void
      {
         this.graphic = null;
         this._background = null;
         this._text = null;
         super.removed();
      }
      
      private function getBackground() : Image
      {
         var data:BitmapData = new BitmapData(this._text.width + 4,this._text.height + 4,true,0);
         var g:Graphics = FP.sprite.graphics;
         g.clear();
         g.beginFill(13421772,1);
         g.lineStyle(1,0);
         g.drawRect(0,0,this._text.width + 3,this._text.height + 3);
         g.endFill();
         data.draw(FP.sprite);
         return new Image(data);
      }
   }
}

