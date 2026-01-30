package entities
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   
   public class Tooltip extends Entity
   {
      
      private var _text:Text;
      
      private var _parent:Button;
      
      public function Tooltip(x:Number, y:Number, text:String, parent:Button)
      {
         super();
         this.layer = Const.TOOLTIP_LAYER;
         this._parent = parent;
         this.x = x;
         this.y = y;
         Text.font = Const.FONT_TEXT;
         Text.size = 12 / Const.FONT_OFFSET;
         this._text = new Text(text);
         this._text.color = 0;
         FP.world.add(this);
      }
      
      override public function added() : void
      {
         if(this.x + this._text.width + 4 > FP.width)
         {
            this.x = FP.width - this._text.width - 4;
         }
         if(this.y + this._text.height + 4 > FP.height)
         {
            this.y = FP.height - this._text.height - 4;
         }
         var data:BitmapData = new BitmapData(this._text.width + 3,this._text.height + 3,true,0);
         var g:Graphics = FP.sprite.graphics;
         g.clear();
         g.beginFill(15658734,0.5);
         g.lineStyle(1,0,0.5);
         g.drawRect(0,0,this._text.width + 2,this._text.height);
         g.endFill();
         data.draw(FP.sprite);
         this.graphic = new Graphiclist(new Image(data),this._text);
         super.added();
      }
      
      override public function removed() : void
      {
         this._parent = null;
         super.removed();
      }
      
      override public function update() : void
      {
         if(Button.current_hover != this._parent)
         {
            FP.world.remove(this);
         }
         super.update();
      }
   }
}

