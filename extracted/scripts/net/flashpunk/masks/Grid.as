package net.flashpunk.masks
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.flashpunk.*;
   
   public class Grid extends Hitbox
   {
      
      public var usePositions:Boolean;
      
      private var _data:BitmapData;
      
      private var _columns:uint;
      
      private var _rows:uint;
      
      private var _tile:Rectangle;
      
      private var _rect:Rectangle = FP.rect;
      
      private var _point:Point = FP.point;
      
      private var _point2:Point = FP.point2;
      
      public function Grid(width:uint, height:uint, tileWidth:uint, tileHeight:uint, x:int = 0, y:int = 0)
      {
         super();
         if(!width || !height || !tileWidth || !tileHeight)
         {
            throw new Error("Illegal Grid, sizes cannot be 0.");
         }
         this._columns = width / tileWidth;
         this._rows = height / tileHeight;
         this._data = new BitmapData(this._columns,this._rows,true,0);
         this._tile = new Rectangle(0,0,tileWidth,tileHeight);
         _x = x;
         _y = y;
         _width = width;
         _height = height;
         _check[Mask] = this.collideMask;
         _check[Hitbox] = this.collideHitbox;
         _check[Pixelmask] = this.collidePixelmask;
      }
      
      public function setTile(column:uint = 0, row:uint = 0, solid:Boolean = true) : void
      {
         if(this.usePositions)
         {
            column /= this._tile.width;
            row /= this._tile.height;
         }
         this._data.setPixel32(column,row,solid ? uint(4294967295) : 0);
      }
      
      public function clearTile(column:uint = 0, row:uint = 0) : void
      {
         this.setTile(column,row,false);
      }
      
      public function getTile(column:uint = 0, row:uint = 0) : Boolean
      {
         if(this.usePositions)
         {
            column /= this._tile.width;
            row /= this._tile.height;
         }
         return this._data.getPixel32(column,row) > 0;
      }
      
      public function setRect(column:uint = 0, row:uint = 0, width:int = 1, height:int = 1, solid:Boolean = true) : void
      {
         if(this.usePositions)
         {
            column /= this._tile.width;
            row /= this._tile.height;
            width /= this._tile.width;
            height /= this._tile.height;
         }
         this._rect.x = column;
         this._rect.y = row;
         this._rect.width = width;
         this._rect.height = height;
         this._data.fillRect(this._rect,solid ? uint(4294967295) : 0);
      }
      
      public function clearRect(column:uint = 0, row:uint = 0, width:int = 1, height:int = 1) : void
      {
         this.setRect(column,row,width,height,false);
      }
      
      public function loadFromString(str:String, columnSep:String = ",", rowSep:String = "\n") : void
      {
         var col:Array = null;
         var cols:int = 0;
         var x:int = 0;
         var y:int = 0;
         var row:Array = str.split(rowSep);
         var rows:int = int(row.length);
         for(y = 0; y < rows; y++)
         {
            if(row[y] != "")
            {
               col = row[y].split(columnSep);
               cols = int(col.length);
               for(x = 0; x < cols; x++)
               {
                  if(col[x] != "")
                  {
                     this.setTile(x,y,uint(col[x]) > 0);
                  }
               }
            }
         }
      }
      
      public function saveToString(columnSep:String = ",", rowSep:String = "\n") : String
      {
         var x:int = 0;
         var y:int = 0;
         var s:String = "";
         for(y = 0; y < this._rows; y++)
         {
            for(x = 0; x < this._columns; x++)
            {
               s += String(this.getTile(x,y));
               if(x != this._columns - 1)
               {
                  s += columnSep;
               }
            }
            if(y != this._rows - 1)
            {
               s += rowSep;
            }
         }
         return s;
      }
      
      public function get tileWidth() : uint
      {
         return this._tile.width;
      }
      
      public function get tileHeight() : uint
      {
         return this._tile.height;
      }
      
      public function get columns() : uint
      {
         return this._columns;
      }
      
      public function get rows() : uint
      {
         return this._rows;
      }
      
      public function get data() : BitmapData
      {
         return this._data;
      }
      
      private function collideMask(other:Mask) : Boolean
      {
         this._rect.x = other.parent.x - other.parent.originX - parent.x + parent.originX;
         this._rect.y = other.parent.y - other.parent.originY - parent.y + parent.originY;
         this._point.x = int((this._rect.x + other.parent.width - 1) / this._tile.width) + 1;
         this._point.y = int((this._rect.y + other.parent.height - 1) / this._tile.height) + 1;
         this._rect.x = int(this._rect.x / this._tile.width);
         this._rect.y = int(this._rect.y / this._tile.height);
         this._rect.width = this._point.x - this._rect.x;
         this._rect.height = this._point.y - this._rect.y;
         return this._data.hitTest(FP.zero,1,this._rect);
      }
      
      private function collideHitbox(other:Hitbox) : Boolean
      {
         this._rect.x = other.parent.x + other._x - parent.x - _x;
         this._rect.y = other.parent.y + other._y - parent.y - _y;
         this._point.x = int((this._rect.x + other._width - 1) / this._tile.width) + 1;
         this._point.y = int((this._rect.y + other._height - 1) / this._tile.height) + 1;
         this._rect.x = int(this._rect.x / this._tile.width);
         this._rect.y = int(this._rect.y / this._tile.height);
         this._rect.width = this._point.x - this._rect.x;
         this._rect.height = this._point.y - this._rect.y;
         return this._data.hitTest(FP.zero,1,this._rect);
      }
      
      private function collidePixelmask(other:Pixelmask) : Boolean
      {
         var x1:int = other.parent.x + other._x - parent.x - _x;
         var y1:int = other.parent.y + other._y - parent.y - _y;
         var x2:int = (x1 + other._width - 1) / this._tile.width;
         var y2:int = (y1 + other._height - 1) / this._tile.height;
         this._point.x = x1;
         this._point.y = y1;
         x1 /= this._tile.width;
         y1 /= this._tile.height;
         this._tile.x = x1 * this._tile.width;
         this._tile.y = y1 * this._tile.height;
         var xx:int = x1;
         while(y1 <= y2)
         {
            while(x1 <= x2)
            {
               if(Boolean(this._data.getPixel32(x1,y1)))
               {
                  if(other._data.hitTest(this._point,1,this._tile))
                  {
                     return true;
                  }
               }
               x1++;
               this._tile.x += this._tile.width;
            }
            x1 = xx;
            y1++;
            this._tile.x = x1 * this._tile.width;
            this._tile.y += this._tile.height;
         }
         return false;
      }
   }
}

