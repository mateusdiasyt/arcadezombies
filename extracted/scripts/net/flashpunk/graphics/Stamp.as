package net.flashpunk.graphics
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   import net.flashpunk.Graphic;
   
   public class Stamp extends Graphic
   {
      
      private var _source:BitmapData;
      
      private var _sourceRect:Rectangle;
      
      public function Stamp(source:*, x:int = 0, y:int = 0)
      {
         super();
         this.x = x;
         this.y = y;
         if(!source)
         {
            return;
         }
         if(source is Class)
         {
            this._source = FP.getBitmap(source);
         }
         else if(source is BitmapData)
         {
            this._source = source;
         }
         if(Boolean(this._source))
         {
            this._sourceRect = this._source.rect;
         }
      }
      
      override public function render(target:BitmapData, point:Point, camera:Point) : void
      {
         if(!this._source)
         {
            return;
         }
         _point.x = point.x + x - camera.x * scrollX;
         _point.y = point.y + y - camera.y * scrollY;
         target.copyPixels(this._source,this._sourceRect,_point,null,null,true);
      }
      
      public function get source() : BitmapData
      {
         return this._source;
      }
      
      public function set source(value:BitmapData) : void
      {
         this._source = value;
         if(Boolean(this._source))
         {
            this._sourceRect = this._source.rect;
         }
      }
   }
}

