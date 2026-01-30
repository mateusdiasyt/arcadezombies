package net.flashpunk.utils
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.Graphic;
   
   public class Draw
   {
      
      public static var blend:String;
      
      private static var _target:BitmapData;
      
      private static var _camera:Point;
      
      private static var _graphics:Graphics = FP.sprite.graphics;
      
      private static var _rect:Rectangle = FP.rect;
      
      private static var _matrix:Matrix = new Matrix();
      
      public function Draw()
      {
         super();
      }
      
      public static function setTarget(target:BitmapData, camera:Point = null, blend:String = null) : void
      {
         _target = target;
         _camera = Boolean(camera) ? camera : FP.zero;
         Draw.blend = blend;
      }
      
      public static function resetTarget() : void
      {
         _target = FP.buffer;
         _camera = FP.camera;
         Draw.blend = null;
      }
      
      public static function line(x1:int, y1:int, x2:int, y2:int, color:uint = 16777215) : void
      {
         var xx:int = 0;
         var yy:int = 0;
         var slope:Number = NaN;
         if(color < 4278190080)
         {
            color = uint(0xFF000000 | color);
         }
         x1 -= _camera.x;
         y1 -= _camera.y;
         x2 -= _camera.x;
         y2 -= _camera.y;
         var screen:BitmapData = _target;
         var X:Number = Math.abs(x2 - x1);
         var Y:Number = Math.abs(y2 - y1);
         if(X == 0)
         {
            if(Y == 0)
            {
               screen.setPixel32(x1,y1,color);
               return;
            }
            yy = y2 > y1 ? 1 : -1;
            while(y1 != y2)
            {
               screen.setPixel32(x1,y1,color);
               y1 += yy;
            }
            screen.setPixel32(x2,y2,color);
            return;
         }
         if(Y == 0)
         {
            xx = x2 > x1 ? 1 : -1;
            while(x1 != x2)
            {
               screen.setPixel32(x1,y1,color);
               x1 += xx;
            }
            screen.setPixel32(x2,y2,color);
            return;
         }
         xx = x2 > x1 ? 1 : -1;
         yy = y2 > y1 ? 1 : -1;
         var c:Number = 0;
         if(X > Y)
         {
            slope = Y / X;
            c = 0.5;
            while(x1 != x2)
            {
               screen.setPixel32(x1,y1,color);
               x1 += xx;
               c += slope;
               if(c >= 1)
               {
                  y1 += yy;
                  c -= 1;
               }
            }
            screen.setPixel32(x2,y2,color);
         }
         else
         {
            slope = X / Y;
            c = 0.5;
            while(y1 != y2)
            {
               screen.setPixel32(x1,y1,color);
               y1 += yy;
               c += slope;
               if(c >= 1)
               {
                  x1 += xx;
                  c -= 1;
               }
            }
            screen.setPixel32(x2,y2,color);
         }
      }
      
      public static function linePlus(x1:int, y1:int, x2:int, y2:int, color:uint = 4278190080, alpha:Number = 1, thick:Number = 1) : void
      {
         _graphics.clear();
         _graphics.lineStyle(thick,color,alpha,false,LineScaleMode.NONE);
         _graphics.moveTo(x1 - _camera.x,y1 - _camera.y);
         _graphics.lineTo(x2 - _camera.x,y2 - _camera.y);
         _target.draw(FP.sprite,null,null,blend);
      }
      
      public static function rect(x:int, y:int, width:uint, height:uint, color:uint = 16777215, alpha:Number = 1) : void
      {
         if(alpha >= 1 && !blend)
         {
            if(color < 4278190080)
            {
               color = uint(0xFF000000 | color);
            }
            _rect.x = x - _camera.x;
            _rect.y = y - _camera.y;
            _rect.width = width;
            _rect.height = height;
            _target.fillRect(_rect,color);
            return;
         }
         if(color >= 4278190080)
         {
            color = uint(0xFFFFFF & color);
         }
         _graphics.clear();
         _graphics.beginFill(color,alpha);
         _graphics.drawRect(x - _camera.x,y - _camera.y,width,height);
         _target.draw(FP.sprite,null,null,blend);
      }
      
      public static function circle(x:int, y:int, radius:int, color:uint = 16777215) : void
      {
         if(color < 4278190080)
         {
            color = uint(0xFF000000 | color);
         }
         x -= _camera.x;
         y -= _camera.y;
         var f:int = 1 - radius;
         var fx:int = 1;
         var fy:int = -2 * radius;
         var xx:int = 0;
         var yy:int = radius;
         _target.setPixel32(x,y + radius,color);
         _target.setPixel32(x,y - radius,color);
         _target.setPixel32(x + radius,y,color);
         _target.setPixel32(x - radius,y,color);
         while(xx < yy)
         {
            if(f >= 0)
            {
               yy--;
               fy += 2;
               f += fy;
            }
            xx++;
            fx += 2;
            f += fx;
            _target.setPixel32(x + xx,y + yy,color);
            _target.setPixel32(x - xx,y + yy,color);
            _target.setPixel32(x + xx,y - yy,color);
            _target.setPixel32(x - xx,y - yy,color);
            _target.setPixel32(x + yy,y + xx,color);
            _target.setPixel32(x - yy,y + xx,color);
            _target.setPixel32(x + yy,y - xx,color);
            _target.setPixel32(x - yy,y - xx,color);
         }
      }
      
      public static function circlePlus(x:int, y:int, radius:Number, color:uint = 16777215, alpha:Number = 1, fill:Boolean = true, thick:int = 1) : void
      {
         _graphics.clear();
         if(fill)
         {
            _graphics.beginFill(color & 0xFFFFFF,alpha);
            _graphics.drawCircle(x - _camera.x,y - _camera.y,radius);
            _graphics.endFill();
         }
         else
         {
            _graphics.lineStyle(thick,color & 0xFFFFFF,alpha);
            _graphics.drawCircle(x - _camera.x,y - _camera.y,radius);
         }
         _target.draw(FP.sprite,null,null,blend);
      }
      
      public static function hitbox(e:Entity, outline:Boolean = true, color:uint = 16777215, alpha:Number = 1) : void
      {
         var x:int = 0;
         var y:int = 0;
         if(outline)
         {
            if(color < 4278190080)
            {
               color = uint(0xFF000000 | color);
            }
            x = e.x - e.originX - _camera.x;
            y = e.y - e.originY - _camera.y;
            _rect.x = x;
            _rect.y = y;
            _rect.width = e.width;
            _rect.height = 1;
            _target.fillRect(_rect,color);
            _rect.y += e.height - 1;
            _target.fillRect(_rect,color);
            _rect.y = y;
            _rect.width = 1;
            _rect.height = e.height;
            _target.fillRect(_rect,color);
            _rect.x += e.width - 1;
            _target.fillRect(_rect,color);
            return;
         }
         if(alpha >= 1 && !blend)
         {
            if(color < 4278190080)
            {
               color = uint(0xFF000000 | color);
            }
            _rect.x = e.x - e.originX - _camera.x;
            _rect.y = e.y - e.originY - _camera.y;
            _rect.width = e.width;
            _rect.height = e.height;
            _target.fillRect(_rect,color);
            return;
         }
         if(color >= 4278190080)
         {
            color = uint(0xFFFFFF & color);
         }
         _graphics.clear();
         _graphics.beginFill(color,alpha);
         _graphics.drawRect(e.x - e.originX - _camera.x,e.y - e.originY - _camera.y,e.width,e.height);
         _target.draw(FP.sprite,null,null,blend);
      }
      
      public static function curve(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int, thick:Number = 1, color:uint = 0, alpha:Number = 1) : void
      {
         _graphics.clear();
         _graphics.lineStyle(thick,color,alpha);
         _graphics.moveTo(x1 - _camera.x,y1 - _camera.y);
         _graphics.curveTo(x2 - _camera.x,y2 - _camera.y,x3 - _camera.x,y3 - _camera.y);
         _target.draw(FP.sprite,null,null,blend);
      }
      
      public static function graphic(g:Graphic, x:int = 0, y:int = 0) : void
      {
         if(g.visible)
         {
            if(g.relative)
            {
               FP.point.x = x;
               FP.point.y = y;
            }
            else
            {
               FP.point.x = FP.point.y = 0;
            }
            FP.point2.x = FP.camera.x;
            FP.point2.y = FP.camera.y;
            g.render(_target,FP.point,FP.point2);
         }
      }
      
      public static function entity(e:Entity, x:int = 0, y:int = 0, addEntityPosition:Boolean = false) : void
      {
         if(e.visible && Boolean(e.graphic))
         {
            if(addEntityPosition)
            {
               graphic(e.graphic,x + e.x,y + e.y);
            }
            else
            {
               graphic(e.graphic,x,y);
            }
         }
      }
   }
}

