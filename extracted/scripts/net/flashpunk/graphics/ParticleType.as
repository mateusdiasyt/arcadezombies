package net.flashpunk.graphics
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   
   public class ParticleType
   {
      
      internal var _name:String;
      
      internal var _source:BitmapData;
      
      internal var _width:uint;
      
      internal var _frame:Rectangle;
      
      internal var _frames:Array;
      
      internal var _frameCount:uint;
      
      internal var _angle:Number;
      
      internal var _angleRange:Number;
      
      internal var _distance:Number;
      
      internal var _distanceRange:Number;
      
      internal var _duration:Number;
      
      internal var _durationRange:Number;
      
      internal var _ease:Function;
      
      internal var _alpha:Number = 1;
      
      internal var _alphaRange:Number = 0;
      
      internal var _alphaEase:Function;
      
      internal var _red:Number = 1;
      
      internal var _redRange:Number = 0;
      
      internal var _green:Number = 1;
      
      internal var _greenRange:Number = 0;
      
      internal var _blue:Number = 1;
      
      internal var _blueRange:Number = 0;
      
      internal var _colorEase:Function;
      
      internal var _buffer:BitmapData;
      
      internal var _bufferRect:Rectangle;
      
      public function ParticleType(name:String, frames:Array, source:BitmapData, frameWidth:uint, frameHeight:uint)
      {
         super();
         this._name = name;
         this._source = source;
         this._width = source.width;
         this._frame = new Rectangle(0,0,frameWidth,frameHeight);
         this._frames = frames;
         this._frameCount = frames.length;
      }
      
      public function setMotion(angle:Number, distance:Number, duration:Number, angleRange:Number = 0, distanceRange:Number = 0, durationRange:Number = 0, ease:Function = null) : ParticleType
      {
         this._angle = angle * FP.RAD;
         this._distance = distance;
         this._duration = duration;
         this._angleRange = angleRange * FP.RAD;
         this._distanceRange = distanceRange;
         this._durationRange = durationRange;
         this._ease = ease;
         return this;
      }
      
      public function setMotionVector(x:Number, y:Number, duration:Number, durationRange:Number = 0, ease:Function = null) : ParticleType
      {
         this._angle = Math.atan2(y,x);
         this._angleRange = 0;
         this._duration = duration;
         this._durationRange = durationRange;
         this._ease = ease;
         return this;
      }
      
      public function setAlpha(start:Number = 1, finish:Number = 0, ease:Function = null) : ParticleType
      {
         start = start < 0 ? 0 : (start > 1 ? 1 : start);
         finish = finish < 0 ? 0 : (finish > 1 ? 1 : finish);
         this._alpha = start;
         this._alphaRange = finish - start;
         this._alphaEase = ease;
         this.createBuffer();
         return this;
      }
      
      public function setColor(start:uint = 16777215, finish:uint = 0, ease:Function = null) : ParticleType
      {
         start &= 16777215;
         finish &= 16777215;
         this._red = (start >> 16 & 0xFF) / 255;
         this._green = (start >> 8 & 0xFF) / 255;
         this._blue = (start & 0xFF) / 255;
         this._redRange = (finish >> 16 & 0xFF) / 255 - this._red;
         this._greenRange = (finish >> 8 & 0xFF) / 255 - this._green;
         this._blueRange = (finish & 0xFF) / 255 - this._blue;
         this._colorEase = ease;
         this.createBuffer();
         return this;
      }
      
      private function createBuffer() : void
      {
         if(Boolean(this._buffer))
         {
            return;
         }
         this._buffer = new BitmapData(this._frame.width,this._frame.height,true,0);
         this._bufferRect = this._buffer.rect;
      }
   }
}

