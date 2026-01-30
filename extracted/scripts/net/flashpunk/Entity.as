package net.flashpunk
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import net.flashpunk.graphics.*;
   import net.flashpunk.masks.*;
   
   public class Entity extends Tweener
   {
      
      public var visible:Boolean = true;
      
      public var collidable:Boolean = true;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var width:int;
      
      public var height:int;
      
      public var originX:int;
      
      public var originY:int;
      
      public var renderTarget:BitmapData;
      
      internal var _class:Class;
      
      internal var _world:World;
      
      internal var _added:Boolean;
      
      internal var _type:String = "";
      
      internal var _layer:int;
      
      internal var _updatePrev:Entity;
      
      internal var _updateNext:Entity;
      
      internal var _renderPrev:Entity;
      
      internal var _renderNext:Entity;
      
      internal var _typePrev:Entity;
      
      internal var _typeNext:Entity;
      
      internal var _recycleNext:Entity;
      
      private const HITBOX:Mask = new Mask();
      
      private var _mask:Mask;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _moveX:Number = 0;
      
      private var _moveY:Number = 0;
      
      internal var _graphic:Graphic;
      
      private var _point:Point = FP.point;
      
      private var _camera:Point = FP.point2;
      
      public function Entity(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null)
      {
         super();
         this.x = x;
         this.y = y;
         if(Boolean(graphic))
         {
            this.graphic = graphic;
         }
         if(Boolean(mask))
         {
            this.mask = mask;
         }
         this.HITBOX.assignTo(this);
         this._class = Class(getDefinitionByName(getQualifiedClassName(this)));
      }
      
      public function added() : void
      {
      }
      
      public function removed() : void
      {
      }
      
      override public function update() : void
      {
      }
      
      public function render() : void
      {
         if(Boolean(this._graphic) && this._graphic.visible)
         {
            if(this._graphic.relative)
            {
               this._point.x = this.x;
               this._point.y = this.y;
            }
            else
            {
               this._point.x = this._point.y = 0;
            }
            this._camera.x = FP.camera.x;
            this._camera.y = FP.camera.y;
            this._graphic.render(Boolean(this.renderTarget) ? this.renderTarget : FP.buffer,this._point,this._camera);
         }
      }
      
      public function collide(type:String, x:Number, y:Number) : Entity
      {
         if(!this._world)
         {
            return null;
         }
         var e:Entity = this._world._typeFirst[type];
         if(!this.collidable || !e)
         {
            return null;
         }
         this._x = this.x;
         this._y = this.y;
         this.x = x;
         this.y = y;
         if(!this._mask)
         {
            while(Boolean(e))
            {
               if(x - this.originX + this.width > e.x - e.originX && y - this.originY + this.height > e.y - e.originY && x - this.originX < e.x - e.originX + e.width && y - this.originY < e.y - e.originY + e.height && e.collidable && e !== this)
               {
                  if(!e._mask || e._mask.collide(this.HITBOX))
                  {
                     this.x = this._x;
                     this.y = this._y;
                     return e;
                  }
               }
               e = e._typeNext;
            }
            this.x = this._x;
            this.y = this._y;
            return null;
         }
         while(Boolean(e))
         {
            if(x - this.originX + this.width > e.x - e.originX && y - this.originY + this.height > e.y - e.originY && x - this.originX < e.x - e.originX + e.width && y - this.originY < e.y - e.originY + e.height && e.collidable && e !== this)
            {
               if(this._mask.collide(Boolean(e._mask) ? e._mask : e.HITBOX))
               {
                  this.x = this._x;
                  this.y = this._y;
                  return e;
               }
            }
            e = e._typeNext;
         }
         this.x = this._x;
         this.y = this._y;
         return null;
      }
      
      public function collideTypes(types:Object, x:Number, y:Number) : Entity
      {
         var e:Entity = null;
         var type:String = null;
         if(!this._world)
         {
            return null;
         }
         for each(type in types)
         {
            e = this.collide(type,x,y);
            if(Boolean(e))
            {
               return e;
            }
         }
         return null;
      }
      
      public function collideWith(e:Entity, x:Number, y:Number) : Entity
      {
         this._x = this.x;
         this._y = this.y;
         this.x = x;
         this.y = y;
         if(x - this.originX + this.width > e.x - e.originX && y - this.originY + this.height > e.y - e.originY && x - this.originX < e.x - e.originX + e.width && y - this.originY < e.y - e.originY + e.height && this.collidable && e.collidable)
         {
            if(!this._mask)
            {
               if(!e._mask || e._mask.collide(this.HITBOX))
               {
                  this.x = this._x;
                  this.y = this._y;
                  return e;
               }
               this.x = this._x;
               this.y = this._y;
               return null;
            }
            if(this._mask.collide(Boolean(e._mask) ? e._mask : e.HITBOX))
            {
               this.x = this._x;
               this.y = this._y;
               return e;
            }
         }
         this.x = this._x;
         this.y = this._y;
         return null;
      }
      
      public function collideRect(x:Number, y:Number, rX:Number, rY:Number, rWidth:Number, rHeight:Number) : Boolean
      {
         if(x - this.originX + this.width >= rX && y - this.originY + this.height >= rY && x - this.originX <= rX + rWidth && y - this.originY <= rY + rHeight)
         {
            if(!this._mask)
            {
               return true;
            }
            this._x = this.x;
            this._y = this.y;
            this.x = x;
            this.y = y;
            FP.entity.x = rX;
            FP.entity.y = rY;
            FP.entity.width = rWidth;
            FP.entity.height = rHeight;
            if(this._mask.collide(FP.entity.HITBOX))
            {
               this.x = this._x;
               this.y = this._y;
               return true;
            }
            this.x = this._x;
            this.y = this._y;
            return false;
         }
         return false;
      }
      
      public function collidePoint(x:Number, y:Number, pX:Number, pY:Number) : Boolean
      {
         if(pX >= x - this.originX && pY >= y - this.originY && pX < x - this.originX + this.width && pY < y - this.originY + this.height)
         {
            if(!this._mask)
            {
               return true;
            }
            this._x = this.x;
            this._y = this.y;
            this.x = x;
            this.y = y;
            FP.entity.x = pX;
            FP.entity.y = pY;
            FP.entity.width = 1;
            FP.entity.height = 1;
            if(this._mask.collide(FP.entity.HITBOX))
            {
               this.x = this._x;
               this.y = this._y;
               return true;
            }
            this.x = this._x;
            this.y = this._y;
            return false;
         }
         return false;
      }
      
      public function collideInto(type:String, x:Number, y:Number, array:Object) : void
      {
         if(!this._world)
         {
            return;
         }
         var e:Entity = this._world._typeFirst[type];
         if(!this.collidable || !e)
         {
            return;
         }
         this._x = this.x;
         this._y = this.y;
         this.x = x;
         this.y = y;
         var n:uint = uint(array.length);
         if(!this._mask)
         {
            while(Boolean(e))
            {
               if(x - this.originX + this.width > e.x - e.originX && y - this.originY + this.height > e.y - e.originY && x - this.originX < e.x - e.originX + e.width && y - this.originY < e.y - e.originY + e.height && e.collidable && e !== this)
               {
                  if(!e._mask || e._mask.collide(this.HITBOX))
                  {
                     array[n++] = e;
                  }
               }
               e = e._typeNext;
            }
            this.x = this._x;
            this.y = this._y;
            return;
         }
         while(Boolean(e))
         {
            if(x - this.originX + this.width > e.x - e.originX && y - this.originY + this.height > e.y - e.originY && x - this.originX < e.x - e.originX + e.width && y - this.originY < e.y - e.originY + e.height && e.collidable && e !== this)
            {
               if(this._mask.collide(Boolean(e._mask) ? e._mask : e.HITBOX))
               {
                  array[n++] = e;
               }
            }
            e = e._typeNext;
         }
         this.x = this._x;
         this.y = this._y;
      }
      
      public function collideTypesInto(types:Object, x:Number, y:Number, array:Object) : void
      {
         var type:String = null;
         if(!this._world)
         {
            return;
         }
         for each(type in types)
         {
            this.collideInto(type,x,y,array);
         }
      }
      
      public function get onCamera() : Boolean
      {
         return this.collideRect(this.x,this.y,FP.camera.x,FP.camera.y,FP.width,FP.height);
      }
      
      public function get world() : World
      {
         return this._world;
      }
      
      public function get halfWidth() : Number
      {
         return this.width / 2;
      }
      
      public function get halfHeight() : Number
      {
         return this.height / 2;
      }
      
      public function get centerX() : Number
      {
         return this.x - this.originX + this.width / 2;
      }
      
      public function get centerY() : Number
      {
         return this.y - this.originY + this.height / 2;
      }
      
      public function get left() : Number
      {
         return this.x - this.originX;
      }
      
      public function get right() : Number
      {
         return this.x - this.originX + this.width;
      }
      
      public function get top() : Number
      {
         return this.y - this.originY;
      }
      
      public function get bottom() : Number
      {
         return this.y - this.originY + this.height;
      }
      
      public function get layer() : int
      {
         return this._layer;
      }
      
      public function set layer(value:int) : void
      {
         if(this._layer == value)
         {
            return;
         }
         if(!this._added)
         {
            this._layer = value;
            return;
         }
         this._world.removeRender(this);
         this._layer = value;
         this._world.addRender(this);
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(value:String) : void
      {
         if(this._type == value)
         {
            return;
         }
         if(!this._added)
         {
            this._type = value;
            return;
         }
         if(Boolean(this._type))
         {
            this._world.removeType(this);
         }
         this._type = value;
         if(Boolean(value))
         {
            this._world.addType(this);
         }
      }
      
      public function get mask() : Mask
      {
         return this._mask;
      }
      
      public function set mask(value:Mask) : void
      {
         if(this._mask == value)
         {
            return;
         }
         if(Boolean(this._mask))
         {
            this._mask.assignTo(null);
         }
         this._mask = value;
         if(Boolean(value))
         {
            this._mask.assignTo(this);
         }
      }
      
      public function get graphic() : Graphic
      {
         return this._graphic;
      }
      
      public function set graphic(value:Graphic) : void
      {
         if(this._graphic == value)
         {
            return;
         }
         this._graphic = value;
         if(Boolean(value) && value._assign != null)
         {
            value._assign();
         }
      }
      
      public function addGraphic(g:Graphic) : Graphic
      {
         var list:Graphiclist = null;
         if(this.graphic is Graphiclist)
         {
            (this.graphic as Graphiclist).add(g);
         }
         else
         {
            list = new Graphiclist();
            if(Boolean(this.graphic))
            {
               list.add(this.graphic);
            }
            this.graphic = list;
         }
         return g;
      }
      
      public function setHitbox(width:int = 0, height:int = 0, originX:int = 0, originY:int = 0) : void
      {
         this.width = width;
         this.height = height;
         this.originX = originX;
         this.originY = originY;
      }
      
      public function setHitboxTo(o:Object) : void
      {
         if(o is Image || o is Rectangle)
         {
            this.setHitbox(o.width,o.height,-o.x,-o.y);
         }
         else
         {
            if(o.hasOwnProperty("width"))
            {
               this.width = o.width;
            }
            if(o.hasOwnProperty("height"))
            {
               this.height = o.height;
            }
            if(Boolean(o.hasOwnProperty("originX")) && !(o is Graphic))
            {
               this.originX = o.originX;
            }
            else if(o.hasOwnProperty("x"))
            {
               this.originX = -o.x;
            }
            if(Boolean(o.hasOwnProperty("originY")) && !(o is Graphic))
            {
               this.originX = o.originY;
            }
            else if(o.hasOwnProperty("y"))
            {
               this.originX = -o.y;
            }
         }
      }
      
      public function setOrigin(x:int = 0, y:int = 0) : void
      {
         this.originX = x;
         this.originY = y;
      }
      
      public function centerOrigin() : void
      {
         this.originX = this.width / 2;
         this.originY = this.height / 2;
      }
      
      public function distanceFrom(e:Entity, useHitboxes:Boolean = false) : Number
      {
         if(!useHitboxes)
         {
            return Math.sqrt((this.x - e.x) * (this.x - e.x) + (this.y - e.y) * (this.y - e.y));
         }
         return FP.distanceRects(this.x - this.originX,this.y - this.originY,this.width,this.height,e.x - e.originX,e.y - e.originY,e.width,e.height);
      }
      
      public function distanceToPoint(px:Number, py:Number, useHitbox:Boolean = false) : Number
      {
         if(!useHitbox)
         {
            return Math.sqrt((this.x - px) * (this.x - px) + (this.y - py) * (this.y - py));
         }
         return FP.distanceRectPoint(px,py,this.x - this.originX,this.y - this.originY,this.width,this.height);
      }
      
      public function distanceToRect(rx:Number, ry:Number, rwidth:Number, rheight:Number) : Number
      {
         return FP.distanceRects(rx,ry,rwidth,rheight,this.x - this.originX,this.y - this.originY,this.width,this.height);
      }
      
      public function toString() : String
      {
         var s:String = String(this._class);
         return s.substring(7,s.length - 1);
      }
      
      public function moveBy(x:Number, y:Number, solidType:String = null, sweep:Boolean = false) : void
      {
         var sign:int = 0;
         var e:Entity = null;
         this._moveX += x;
         this._moveY += y;
         x = Math.round(this._moveX);
         y = Math.round(this._moveY);
         this._moveX -= x;
         this._moveY -= y;
         if(Boolean(solidType))
         {
            if(x != 0)
            {
               if(this.collidable && (sweep || this.collide(solidType,this.x + x,this.y)))
               {
                  sign = x > 0 ? 1 : -1;
                  while(x != 0)
                  {
                     e = this.collide(solidType,this.x + sign,this.y);
                     if(Boolean(e))
                     {
                        this.moveCollideX(e);
                        break;
                     }
                     this.x += sign;
                     x -= sign;
                  }
               }
               else
               {
                  this.x += x;
               }
            }
            if(y != 0)
            {
               if(this.collidable && (sweep || this.collide(solidType,this.x,this.y + y)))
               {
                  sign = y > 0 ? 1 : -1;
                  while(y != 0)
                  {
                     e = this.collide(solidType,this.x,this.y + sign);
                     if(Boolean(e))
                     {
                        this.moveCollideY(e);
                        break;
                     }
                     this.y += sign;
                     y -= sign;
                  }
               }
               else
               {
                  this.y += y;
               }
            }
         }
         else
         {
            this.x += x;
            this.y += y;
         }
      }
      
      public function moveTo(x:Number, y:Number, solidType:String = null, sweep:Boolean = false) : void
      {
         this.moveBy(x - this.x,y - this.y,solidType,sweep);
      }
      
      public function moveTowards(x:Number, y:Number, amount:Number, solidType:String = null, sweep:Boolean = false) : void
      {
         this._point.x = x - this.x;
         this._point.y = y - this.y;
         this._point.normalize(amount);
         this.moveBy(this._point.x,this._point.y,solidType,sweep);
      }
      
      public function moveCollideX(e:Entity) : void
      {
      }
      
      public function moveCollideY(e:Entity) : void
      {
      }
      
      public function clampHorizontal(left:Number, right:Number, padding:Number = 0) : void
      {
         if(this.x - this.originX < left + padding)
         {
            this.x = left + this.originX + padding;
         }
         if(this.x - this.originX + this.width > right - padding)
         {
            this.x = right - this.width + this.originX - padding;
         }
      }
      
      public function clampVertical(top:Number, bottom:Number, padding:Number = 0) : void
      {
         if(this.y - this.originY < top + padding)
         {
            this.y = top + this.originY + padding;
         }
         if(this.y - this.originY + this.height > bottom - padding)
         {
            this.y = bottom - this.height + this.originY - padding;
         }
      }
   }
}

