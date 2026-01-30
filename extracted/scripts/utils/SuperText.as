package utils
{
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   
   public class SuperText extends Image
   {
      
      public static var font:String = "default";
      
      public static var size:uint = 16;
      
      public static var align:String = "left";
      
      public static var wordWrap:Boolean = false;
      
      public static var resizable:Boolean = true;
      
      [Embed(source="../net/flashpunk/graphics/04B_03__.TTF",embedAsCFF="false",fontFamily="default")]
      private static var _FONT_DEFAULT:Class = SuperText__FONT_DEFAULT;
      
      public var resizable:Boolean;
      
      public var outlineColor:uint = 0;
      
      public var outlineStrength:uint = 0;
      
      private var _field:TextField;
      
      private var _width:uint;
      
      private var _height:uint;
      
      private var _textWidth:uint;
      
      private var _textHeight:uint;
      
      private var _form:TextFormat;
      
      private var _text:String;
      
      private var _font:String;
      
      private var _size:uint;
      
      private var _align:String;
      
      private var _wordWrap:Boolean;
      
      private var _outlineFilter:GlowFilter;
      
      public function SuperText(text:String, x:Number = 0, y:Number = 0, options:Object = null, h:Number = 0)
      {
         var property:String = null;
         this._field = new TextField();
         this._font = Text.font;
         this._size = Text.size;
         var width:uint = 0;
         var height:uint = h;
         if(Boolean(options))
         {
            if(options is Number)
            {
               width = Number(options);
               options = null;
            }
            else
            {
               if(options.hasOwnProperty("font"))
               {
                  this._font = options.font;
               }
               if(options.hasOwnProperty("size"))
               {
                  this._size = options.size;
               }
               if(options.hasOwnProperty("align"))
               {
                  this._align = options.align;
               }
               if(options.hasOwnProperty("wordWrap"))
               {
                  this._wordWrap = options.wordWrap;
               }
               if(options.hasOwnProperty("resizable"))
               {
                  this.resizable = options.resizable;
               }
               if(options.hasOwnProperty("width"))
               {
                  width = uint(options.width);
               }
               if(options.hasOwnProperty("height"))
               {
                  height = uint(options.height);
               }
               if(options.hasOwnProperty("outlineColor"))
               {
                  this.outlineColor = options.outlineColor;
               }
               if(options.hasOwnProperty("outlineStrength"))
               {
                  this.outlineStrength = options.outlineStrength;
               }
            }
         }
         this._field.embedFonts = true;
         this._field.wordWrap = this._wordWrap;
         this._form = new TextFormat(this._font,this._size,16777215);
         this._form.align = this._align;
         this._field.defaultTextFormat = this._form;
         this._field.text = this._text = text;
         this._width = width || uint(this._field.textWidth + 4);
         this._height = height || uint(this._field.textHeight + 4);
         _source = new BitmapData(this._width,this._height,true,0);
         this._outlineFilter = new GlowFilter(this.outlineColor,1,this.outlineStrength,this.outlineStrength,this.outlineStrength * 4);
         super(_source);
         this.updateTextBuffer();
         this.x = x;
         this.y = y;
         if(Boolean(options))
         {
            for(property in options)
            {
               if(!hasOwnProperty(property))
               {
                  throw new Error("\"" + property + "\" is not a property of Text");
               }
               this[property] = options[property];
            }
         }
      }
      
      public function updateTextBuffer() : void
      {
         var tlm:TextLineMetrics = null;
         var remainder:Number = NaN;
         this._field.setTextFormat(this._form);
         this._field.width = this._width;
         this._textWidth = this._field.textWidth + 4;
         this._textHeight = this._field.textHeight + 4;
         this._field.filters = [];
         if(this.outlineStrength > 0)
         {
            this._outlineFilter.blurX = this._outlineFilter.blurY = this.outlineStrength;
            this._outlineFilter.strength = this.outlineStrength * 4;
            this._outlineFilter.color = this.outlineColor;
            this._field.filters = [this._outlineFilter];
         }
         if(this.resizable && (this._textWidth > this._width || this._textHeight > this._height))
         {
            if(this._width < this._textWidth)
            {
               this._width = this._textWidth;
            }
            if(this._height < this._textHeight)
            {
               this._height = this._textHeight;
            }
         }
         if(this._width > _source.width || this._height > _source.height)
         {
            _source = new BitmapData(Math.max(this._width,_source.width),Math.max(this._height,_source.height),true,0);
            _sourceRect = _source.rect;
            createBuffer();
         }
         else
         {
            _source.fillRect(_sourceRect,0);
         }
         this._field.width = this._width;
         this._field.height = this._height;
         var offsetRequired:Boolean = false;
         for(var i:int = 0; i < this._field.numLines; i++)
         {
            tlm = this._field.getLineMetrics(i);
            remainder = tlm.x % 1;
            if(remainder > 0.1 && remainder < 0.9)
            {
               offsetRequired = true;
               break;
            }
         }
         if(offsetRequired)
         {
            for(i = 0; i < this._field.numLines; i++)
            {
               tlm = this._field.getLineMetrics(i);
               remainder = tlm.x % 1;
               this._field.x = -remainder;
               FP.rect.x = 0;
               FP.rect.y = 2 + tlm.height * i;
               FP.rect.width = this._width;
               FP.rect.height = tlm.height;
               _source.draw(this._field,this._field.transform.matrix,null,null,FP.rect);
            }
         }
         else
         {
            _source.draw(this._field);
         }
         super.updateBuffer();
      }
      
      override public function centerOrigin() : void
      {
         originX = this._width / 2;
         originY = this._height / 2;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(value:String) : void
      {
         if(this._text == value)
         {
            return;
         }
         this._field.text = this._text = value;
         this.updateTextBuffer();
      }
      
      public function get font() : String
      {
         return this._font;
      }
      
      public function set font(value:String) : void
      {
         if(this._font == value)
         {
            return;
         }
         this._form.font = this._font = value;
         this.updateTextBuffer();
      }
      
      public function get size() : uint
      {
         return this._size;
      }
      
      public function set size(value:uint) : void
      {
         if(this._size == value)
         {
            return;
         }
         this._form.size = this._size = value;
         this.updateTextBuffer();
      }
      
      public function get align() : String
      {
         return this._align;
      }
      
      public function set align(value:String) : void
      {
         if(this._align == value)
         {
            return;
         }
         this._form.align = this._align = value;
         this.updateTextBuffer();
      }
      
      public function get wordWrap() : Boolean
      {
         return this._wordWrap;
      }
      
      public function set wordWrap(value:Boolean) : void
      {
         if(this._wordWrap == value)
         {
            return;
         }
         this._field.wordWrap = this._wordWrap = value;
         this.updateTextBuffer();
      }
      
      override public function get width() : uint
      {
         return this._width;
      }
      
      public function set width(value:uint) : void
      {
         if(this._width == value)
         {
            return;
         }
         this._width = value;
         this.updateTextBuffer();
      }
      
      override public function get height() : uint
      {
         return this._height;
      }
      
      public function set height(value:uint) : void
      {
         if(this._height == value)
         {
            return;
         }
         this._height = value;
         this.updateTextBuffer();
      }
      
      override public function get scaledWidth() : uint
      {
         return this._width * scaleX * scale;
      }
      
      override public function get scaledHeight() : uint
      {
         return this._height * scaleY * scale;
      }
      
      public function get textWidth() : uint
      {
         return this._textWidth;
      }
      
      public function get textHeight() : uint
      {
         return this._textHeight;
      }
   }
}

