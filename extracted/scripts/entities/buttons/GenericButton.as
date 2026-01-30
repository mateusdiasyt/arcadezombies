package entities.buttons
{
   import entities.Button;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.graphics.Text;
   
   public class GenericButton extends Button
   {
      
      private var gl:Graphiclist = new Graphiclist();
      
      private var button:Spritemap;
      
      private var drawnBg:Image = null;
      
      private var text:String = "";
      
      private var orangeText:Text;
      
      private var callback:Function = null;
      
      private var small:Boolean = false;
      
      private var useDrawnStyle:Boolean = false;
      
      private var ol1:Text;
      
      private var ol2:Text;
      
      private var ol3:Text;
      
      private var ol4:Text;
      
      private var enabled:Boolean = true;
      
      public var suppressed:Boolean = true;
      
      private static const DRAWN_W:Number = 200;
      
      private static const DRAWN_H:Number = 36;
      
      private static const DRAWN_COLOR:uint = 0x6B4E0A;
      
      private static const DRAWN_HOVER:uint = 0xE8DCC8;
      
      public function GenericButton(text:String, x:Number, y:Number, callback:Function = null, small:Boolean = false, useDrawnStyle:Boolean = false)
      {
         super();
         this.x = x;
         this.y = y;
         this.callback = callback;
         this.small = small;
         this.useDrawnStyle = useDrawnStyle;
         this.text = text;
         if(useDrawnStyle)
         {
            this.drawnBg = Image.createRect(DRAWN_W, DRAWN_H, DRAWN_COLOR);
            this.setHitbox(DRAWN_W, DRAWN_H);
            this.setTextDrawn(this.text);
            this.gl.add(this.drawnBg);
            this.gl.add(this.ol1);
            this.gl.add(this.ol2);
            this.gl.add(this.ol3);
            this.gl.add(this.ol4);
            this.gl.add(this.orangeText);
            this.graphic = this.gl;
            return;
         }
         else
         {
            if(small)
            {
               this.button = new Spritemap(Assets.GFX_BUTTON_SMALL,66,24);
               this.setHitbox(66,24);
            }
            else
            {
               this.button = new Spritemap(Assets.GFX_BUTTON,138,24);
               this.setHitbox(138,24);
            }
            this.setText(this.text);
            this.button.add("normal",[0]);
            this.button.add("over",[1]);
            this.button.add("disabled",[2]);
            this.button.play("normal");
         }
      }
      
      private function setTextDrawn(t:String) : void
      {
         Text.size = 18;
         Text.font = "_sans";
         this.orangeText = new Text(t, 0, 0);
         this.orangeText.color = 0xFFFFFF;
         this.orangeText.x = (DRAWN_W - this.orangeText.width) / 2;
         this.orangeText.y = (DRAWN_H - this.orangeText.height) / 2 - 2;
         this.ol1 = new Text(t, 0, 0);
         this.ol1.color = 0;
         this.ol1.x = this.orangeText.x - 1;
         this.ol1.y = this.orangeText.y - 1;
         this.ol2 = new Text(t, 0, 0);
         this.ol2.color = 0;
         this.ol2.x = this.orangeText.x - 1;
         this.ol2.y = this.orangeText.y + 1;
         this.ol3 = new Text(t, 0, 0);
         this.ol3.color = 0;
         this.ol3.x = this.orangeText.x + 1;
         this.ol3.y = this.orangeText.y - 1;
         this.ol4 = new Text(t, 0, 0);
         this.ol4.color = 0;
         this.ol4.x = this.orangeText.x + 1;
         this.ol4.y = this.orangeText.y + 1;
      }
      
      override public function added() : void
      {
         if(this.useDrawnStyle)
         {
            super.added();
            return;
         }
         if(this.button == null)
         {
            if(this.small)
            {
               this.button = new Spritemap(Assets.GFX_BUTTON_SMALL,66,24);
               this.setHitbox(66,24);
            }
            else
            {
               this.button = new Spritemap(Assets.GFX_BUTTON,138,24);
               this.setHitbox(138,24);
            }
            this.setText(this.text);
            this.button.add("normal",[0]);
            this.button.add("over",[1]);
            this.button.add("disabled",[2]);
            this.button.play("normal");
         }
         super.added();
      }
      
      private function setText(text:String) : void
      {
         if(this.button == null) return;
         Text.size = 16 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this.orangeText = new Text(text,0,0);
         this.orangeText.color = 1575940;
         this.orangeText.x = (this.button.width - this.orangeText.width) / 2;
         if(Const.FONT_TEXT == "Blah")
         {
            this.orangeText.y = 3;
         }
         else
         {
            this.orangeText.y = 1;
         }
         this.ol1 = new Text(text,0,0);
         this.ol1.color = 16773806;
         this.ol1.x = this.orangeText.x - 1;
         this.ol1.y = this.orangeText.y - 1;
         this.ol2 = new Text(text,0,0);
         this.ol2.color = 16773806;
         this.ol2.x = this.orangeText.x - 1;
         this.ol2.y = this.orangeText.y + 1;
         this.ol3 = new Text(text,0,0);
         this.ol3.color = 16773806;
         this.ol3.x = this.orangeText.x + 1;
         this.ol3.y = this.orangeText.y - 1;
         this.ol4 = new Text(text,0,0);
         this.ol4.color = 16773806;
         this.ol4.x = this.orangeText.x + 1;
         this.ol4.y = this.orangeText.y + 1;
         this.gl = new Graphiclist();
         this.gl.add(this.button);
         this.gl.add(this.ol1);
         this.gl.add(this.ol2);
         this.gl.add(this.ol3);
         this.gl.add(this.ol4);
         this.gl.add(this.orangeText);
         this.graphic = this.gl;
      }
      
      override public function clickAction() : void
      {
         if(!this.enabled || this.suppressed) return;
         if(this.callback != null) this.callback();
         if(this.useDrawnStyle && this.drawnBg != null) this.drawnBg.color = 0xFFFFFF;
         else if(Boolean(this.button)) this.button.play("normal");
      }
      
      override public function mouseOver() : void
      {
         if(!this.enabled) return;
         if(this.useDrawnStyle && this.drawnBg != null) this.drawnBg.color = DRAWN_HOVER;
         else if(Boolean(this.button)) this.button.play("over");
      }
      
      override public function mouseOut() : void
      {
         if(!this.enabled) return;
         if(this.useDrawnStyle && this.drawnBg != null) this.drawnBg.color = 0xFFFFFF;
         else if(Boolean(this.button)) this.button.play("normal");
      }
      
      public function enable() : void
      {
         this.enabled = true;
         if(this.orangeText != null) this.orangeText.color = this.useDrawnStyle ? 0xFFFFFF : 1575940;
         if(this.ol1 != null) this.ol1.color = this.useDrawnStyle ? 0 : 16773806;
         if(this.ol2 != null) this.ol2.color = this.useDrawnStyle ? 0 : 16773806;
         if(this.ol3 != null) this.ol3.color = this.useDrawnStyle ? 0 : 16773806;
         if(this.ol4 != null) this.ol4.color = this.useDrawnStyle ? 0 : 16773806;
         if(this.drawnBg != null) this.drawnBg.color = 0xFFFFFF;
         else if(Boolean(this.button)) this.button.play("normal");
      }
      
      public function reset() : void
      {
         this.suppressed = false;
      }
      
      public function disable(str:String = "") : void
      {
         this.enabled = false;
         if(str != "" && !this.useDrawnStyle) { this.text = str; this.setText(str); }
         if(this.orangeText != null) this.orangeText.color = 5263440;
         if(this.ol1 != null) this.ol1.color = 13816530;
         if(this.ol2 != null) this.ol2.color = 13816530;
         if(this.ol3 != null) this.ol3.color = 13816530;
         if(this.ol4 != null) this.ol4.color = 13816530;
         if(!this.useDrawnStyle && Boolean(this.button)) this.button.play("disabled");
      }
      
      override public function removed() : void
      {
         this.orangeText = null;
         this.ol1 = null;
         this.ol2 = null;
         this.ol3 = null;
         this.ol4 = null;
         this.button = null;
         this.drawnBg = null;
         this.gl = null;
         this.graphic = null;
         super.removed();
      }
   }
}

