package net.flashpunk.graphics
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   import net.flashpunk.Graphic;
   
   public class Emitter extends Graphic
   {
      
      private static const SIN:Number = Math.PI / 2;
      
      private var _types:Object = {};
      
      private var _particle:Particle;
      
      private var _cache:Particle;
      
      private var _particleCount:uint;
      
      private var _source:BitmapData;
      
      private var _width:uint;
      
      private var _height:uint;
      
      private var _frameWidth:uint;
      
      private var _frameHeight:uint;
      
      private var _frameCount:uint;
      
      private var _p:Point = new Point();
      
      private var _tint:ColorTransform = new ColorTransform();
      
      public function Emitter(source:*, frameWidth:uint = 0, frameHeight:uint = 0)
      {
         super();
         this.setSource(source,frameWidth,frameHeight);
         active = true;
      }
      
      public function setSource(source:*, frameWidth:uint = 0, frameHeight:uint = 0) : void
      {
         if(source is Class)
         {
            this._source = FP.getBitmap(source);
         }
         else if(source is BitmapData)
         {
            this._source = source;
         }
         if(!this._source)
         {
            throw new Error("Invalid source image.");
         }
         this._width = this._source.width;
         this._height = this._source.height;
         this._frameWidth = Boolean(frameWidth) ? frameWidth : this._width;
         this._frameHeight = Boolean(frameHeight) ? frameHeight : this._height;
         this._frameCount = uint(this._width / this._frameWidth) * uint(this._height / this._frameHeight);
      }
      
      override public function update() : void
      {
         var n:Particle = null;
         var t:Number = NaN;
         if(!this._particle)
         {
            return;
         }
         var e:Number = FP.fixed ? 1 : FP.elapsed;
         var p:Particle = this._particle;
         while(Boolean(p))
         {
            p._time += e;
            t = p._time / p._duration;
            if(p._time >= p._duration)
            {
               if(Boolean(p._next))
               {
                  p._next._prev = p._prev;
               }
               if(Boolean(p._prev))
               {
                  p._prev._next = p._next;
               }
               else
               {
                  this._particle = p._next;
               }
               n = p._next;
               p._next = this._cache;
               p._prev = null;
               this._cache = p;
               p = n;
               --this._particleCount;
            }
            else
            {
               p = p._next;
            }
         }
      }
      
      override public function render(target:BitmapData, point:Point, camera:Point) : void
      {
         var t:Number = NaN;
         var td:Number = NaN;
         var type:ParticleType = null;
         var rect:Rectangle = null;
         if(!this._particle)
         {
            return;
         }
         _point.x = point.x + x - camera.x * scrollX;
         _point.y = point.y + y - camera.y * scrollY;
         var p:Particle = this._particle;
         while(Boolean(p))
         {
            t = p._time / p._duration;
            type = p._type;
            rect = type._frame;
            td = type._ease == null ? t : Number(type._ease(t));
            this._p.x = _point.x + p._x + p._moveX * td;
            this._p.y = _point.y + p._y + p._moveY * td;
            rect.x = rect.width * type._frames[uint(td * type._frameCount)];
            rect.y = uint(rect.x / type._width) * rect.height;
            rect.x %= type._width;
            if(Boolean(type._buffer))
            {
               this._tint.alphaMultiplier = type._alpha + type._alphaRange * (type._alphaEase == null ? t : type._alphaEase(t));
               td = type._colorEase == null ? t : Number(type._colorEase(t));
               this._tint.redMultiplier = type._red + type._redRange * td;
               this._tint.greenMultiplier = type._green + type._greenRange * td;
               this._tint.blueMultiplier = type._blue + type._blueRange * td;
               type._buffer.fillRect(type._bufferRect,0);
               type._buffer.copyPixels(type._source,rect,FP.zero);
               type._buffer.colorTransform(type._bufferRect,this._tint);
               target.copyPixels(type._buffer,type._bufferRect,this._p,null,null,true);
            }
            else
            {
               target.copyPixels(type._source,rect,this._p,null,null,true);
            }
            p = p._next;
         }
      }
      
      public function newType(name:String, frames:Array = null) : ParticleType
      {
         if(Boolean(this._types[name]))
         {
            throw new Error("Cannot add multiple particle types of the same name");
         }
         return this._types[name] = new ParticleType(name,frames,this._source,this._frameWidth,this._frameHeight);
      }
      
      public function setMotion(name:String, angle:Number, distance:Number, duration:Number, angleRange:Number = 0, distanceRange:Number = 0, durationRange:Number = 0, ease:Function = null) : ParticleType
      {
         return (this._types[name] as ParticleType).setMotion(angle,distance,duration,angleRange,distanceRange,durationRange,ease);
      }
      
      public function setAlpha(name:String, start:Number = 1, finish:Number = 0, ease:Function = null) : ParticleType
      {
         return (this._types[name] as ParticleType).setAlpha(start,finish,ease);
      }
      
      public function setColor(name:String, start:uint = 16777215, finish:uint = 0, ease:Function = null) : ParticleType
      {
         return (this._types[name] as ParticleType).setColor(start,finish,ease);
      }
      
      public function emit(name:String, x:Number, y:Number) : Particle
      {
         var p:Particle = null;
         if(!this._types[name])
         {
            throw new Error("Particle type \"" + name + "\" does not exist.");
         }
         var type:ParticleType = this._types[name];
         if(Boolean(this._cache))
         {
            p = this._cache;
            this._cache = p._next;
         }
         else
         {
            p = new Particle();
         }
         p._next = this._particle;
         p._prev = null;
         if(Boolean(p._next))
         {
            p._next._prev = p;
         }
         p._type = type;
         p._time = 0;
         p._duration = type._duration + type._durationRange * FP.random;
         var a:Number = type._angle + type._angleRange * FP.random;
         var d:Number = type._distance + type._distanceRange * FP.random;
         p._moveX = Math.cos(a) * d;
         p._moveY = Math.sin(a) * d;
         p._x = x;
         p._y = y;
         ++this._particleCount;
         return this._particle = p;
      }
      
      public function get particleCount() : uint
      {
         return this._particleCount;
      }
   }
}

