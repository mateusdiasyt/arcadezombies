package net.flashpunk.graphics
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.flashpunk.*;
   
   public class Image extends Graphic
   {
      
      private static var _flips:Object = {};
      
      public var angle:Number = 0;
      
      public var scale:Number = 1;
      
      public var scaleX:Number = 1;
      
      public var scaleY:Number = 1;
      
      public var originX:int;
      
      public var originY:int;
      
      public var blend:String;
      
      public var smooth:Boolean;
      
      protected var _source:BitmapData;
      
      protected var _sourceRect:Rectangle;
      
      protected var _buffer:BitmapData;
      
      protected var _bufferRect:Rectangle;
      
      protected var _bitmap:Bitmap = new Bitmap();
      
      private var _alpha:Number = 1;
      
      private var _color:uint = 16777215;
      
      protected var _tint:ColorTransform;
      
      private var _colorTransform:ColorTransform = new ColorTransform();
      
      private var _matrix:Matrix = FP.matrix;
      
      private var _class:String;
      
      protected var _flipped:Boolean;
      
      private var _flip:BitmapData;
      
      public function Image(source:* = null, clipRect:Rectangle = null)
      {
         super();
         if(source is Class)
         {
            this._source = FP.getBitmap(source);
            this._class = String(source);
         }
         else if(source is BitmapData)
         {
            this._source = source;
         }
         if(!this._source)
         {
            throw new Error("Invalid source image.");
         }
         this._sourceRect = this._source.rect;
         if(Boolean(clipRect))
         {
            if(!clipRect.width)
            {
               clipRect.width = this._sourceRect.width;
            }
            if(!clipRect.height)
            {
               clipRect.height = this._sourceRect.height;
            }
            this._sourceRect = clipRect;
         }
         this.createBuffer();
         this.updateBuffer();
      }
      
      public static function createRect(width:uint, height:uint, color:uint = 16777215) : Image
      {
         var source:BitmapData = new BitmapData(width,height,true,0xFF000000 | color);
         return new Image(source);
      }
      
      public static function createCircle(radius:uint, color:uint = 16777215) : Image
      {
         FP.sprite.graphics.clear();
         FP.sprite.graphics.beginFill(color);
         FP.sprite.graphics.drawCircle(radius,radius,radius);
         var data:BitmapData = new BitmapData(radius * 2,radius * 2,true,0);
         data.draw(FP.sprite);
         return new Image(data);
      }
      
      protected function createBuffer() : void
      {
         this._buffer = new BitmapData(this._sourceRect.width,this._sourceRect.height,true,0);
         this._bufferRect = this._buffer.rect;
         this._bitmap.bitmapData = this._buffer;
      }
      
      override public function render(target:BitmapData, point:Point, camera:Point) : void
      {
         if(!this._buffer)
         {
            return;
         }
         _point.x = point.x + x - camera.x * scrollX;
         _point.y = point.y + y - camera.y * scrollY;
         if(this.angle == 0 && this.scaleX * this.scale == 1 && this.scaleY * this.scale == 1 && !this.blend)
         {
            target.copyPixels(this._buffer,this._bufferRect,_point,null,null,true);
            return;
         }
         this._matrix.b = this._matrix.c = 0;
         this._matrix.a = this.scaleX * this.scale;
         this._matrix.d = this.scaleY * this.scale;
         this._matrix.tx = -this.originX * this._matrix.a;
         this._matrix.ty = -this.originY * this._matrix.d;
         if(this.angle != 0)
         {
            this._matrix.rotate(this.angle * FP.RAD);
         }
         this._matrix.tx += this.originX + _point.x;
         this._matrix.ty += this.originY + _point.y;
         target.draw(this._bitmap,this._matrix,null,this.blend,null,this.smooth);
      }
      
      public function updateBuffer(clearBefore:Boolean = false) : void
      {
         if(!this._source)
         {
            return;
         }
         if(clearBefore)
         {
            this._buffer.fillRect(this._bufferRect,0);
         }
         this._buffer.copyPixels(this._source,this._sourceRect,FP.zero);
         if(Boolean(this._tint))
         {
            this._buffer.colorTransform(this._bufferRect,this._tint);
         }
      }
      
      public function clear() : void
      {
         this._buffer.fillRect(this._bufferRect,0);
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(value:Number) : void
      {
         value = value < 0 ? 0 : (value > 1 ? 1 : value);
         if(this._alpha == value)
         {
            return;
         }
         this._alpha = value;
         if(this._alpha == 1 && this._color == 16777215)
         {
            this._tint = null;
            return this.updateBuffer();
         }
         this._tint = this._colorTransform;
         this._tint.redMultiplier = (this._color >> 16 & 0xFF) / 255;
         this._tint.greenMultiplier = (this._color >> 8 & 0xFF) / 255;
         this._tint.blueMultiplier = (this._color & 0xFF) / 255;
         this._tint.alphaMultiplier = this._alpha;
         this.updateBuffer();
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(value:uint) : void
      {
         value &= 16777215;
         if(this._color == value)
         {
            return;
         }
         this._color = value;
         if(this._alpha == 1 && this._color == 16777215)
         {
            this._tint = null;
            return this.updateBuffer();
         }
         this._tint = this._colorTransform;
         this._tint.redMultiplier = (this._color >> 16 & 0xFF) / 255;
         this._tint.greenMultiplier = (this._color >> 8 & 0xFF) / 255;
         this._tint.blueMultiplier = (this._color & 0xFF) / 255;
         this._tint.alphaMultiplier = this._alpha;
         this.updateBuffer();
      }
      
      public function get flipped() : Boolean
      {
         return this._flipped;
      }
      
      public function set flipped(value:Boolean) : void
      {
         if(this._flipped == value || !this._class)
         {
            return;
         }
         this._flipped = value;
         var temp:BitmapData = this._source;
         if(!value || Boolean(this._flip))
         {
            this._source = this._flip;
            this._flip = temp;
            return this.updateBuffer();
         }
         if(Boolean(_flips[this._class]))
         {
            this._source = _flips[this._class];
            this._flip = temp;
            return this.updateBuffer();
         }
         this._source = _flips[this._class] = new BitmapData(this._source.width,this._source.height,true,0);
         this._flip = temp;
         FP.matrix.identity();
         FP.matrix.a = -1;
         FP.matrix.tx = this._source.width;
         this._source.draw(temp,FP.matrix);
         this.updateBuffer();
      }
      
      public function centerOrigin() : void
      {
         this.originX = this._bufferRect.width / 2;
         this.originY = this._bufferRect.height / 2;
      }
      
      public function centerOO() : void
      {
         x += this.originX;
         y += this.originY;
         this.centerOrigin();
         x -= this.originX;
         y -= this.originY;
      }
      
      public function get width() : uint
      {
         return this._bufferRect.width;
      }
      
      public function get height() : uint
      {
         return this._bufferRect.height;
      }
      
      public function get scaledWidth() : uint
      {
         return this._bufferRect.width * this.scaleX * this.scale;
      }
      
      public function get scaledHeight() : uint
      {
         return this._bufferRect.height * this.scaleY * this.scale;
      }
      
      public function get clipRect() : Rectangle
      {
         return this._sourceRect;
      }
      
      public function get source() : BitmapData
      {
         return this._source;
      }
   }
}

