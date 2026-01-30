package spill.localisation
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   
   use namespace spil_internal;
   
   public class TextFieldFit extends MovieClip
   {
      
      private static const gutter:Number = 2;
      
      spil_internal static var embedFonts:Boolean = true;
      
      spil_internal static var forceFont:String = null;
      
      spil_internal static var forceAAType:String = null;
      
      public static var alwaysCheckWidth:Boolean = false;
      
      private var field:TextField;
      
      private var w:Number;
      
      private var h:Number;
      
      private var format:TextFormat;
      
      private var embeddedFonts:Array;
      
      private var sizeChanged:Boolean = true;
      
      private var debugBounding:Sprite;
      
      private var valid:Boolean = true;
      
      protected var _text:String = "default";
      
      protected var _textColor:uint = 0;
      
      protected var _textSize:Number = 12;
      
      protected var _multiline:Boolean = false;
      
      protected var _disableWordwrap:Boolean = false;
      
      protected var _hAlign:String = "left";
      
      protected var _vAlign:String = "top";
      
      protected var _bold:Boolean = false;
      
      protected var _underline:Boolean = false;
      
      protected var _italic:Boolean = false;
      
      protected var _selectable:Boolean = false;
      
      protected var _font:String = "";
      
      protected var _embedFonts:Boolean = true;
      
      protected var _antiAliasType:String = "advanced";
      
      protected var _gridFitType:String = "pixel";
      
      protected var _useGlowFilter:Boolean = false;
      
      protected var _glowBlur:Number = 3;
      
      protected var _glowColor:uint = 0;
      
      protected var _glowStrength:Number = 5;
      
      protected var _glowQuality:Number = 1;
      
      public function TextFieldFit()
      {
         super();
         var _loc1_:Boolean = parent != null && getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent";
         var _loc2_:Number = width;
         var _loc3_:Number = height;
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         if(!field)
         {
            field = new TextField();
            addChild(field);
         }
         field.border = false;
         field.background = false;
         field.type = TextFieldType.DYNAMIC;
         mouseEnabled = false;
         mouseChildren = false;
         format = new TextFormat();
         embeddedFonts = Font.enumerateFonts(false);
         setSize(_loc2_,_loc3_);
         validate();
         if(Boolean(stage))
         {
            addEventListener(Event.RENDER,init);
            stage.invalidate();
         }
         init();
      }
      
      public function get textField() : TextField
      {
         return field;
      }
      
      private function init(param1:Event = null) : void
      {
         removeEventListener(Event.RENDER,init);
         updateProperties();
         layoutText();
      }
      
      protected function updateProperties() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Font = null;
         field.text = _text;
         field.multiline = _text.indexOf(" ") < 0 && _text.length < 14 ? false : _multiline;
         field.wordWrap = field.multiline && !_disableWordwrap;
         field.selectable = _selectable;
         field.antiAliasType = Boolean(forceAAType) ? forceAAType : _antiAliasType;
         field.gridFitType = _gridFitType;
         embeddedFonts = Font.enumerateFonts(false);
         if(_embedFonts && _font != "" && Boolean(TextFieldFit.embedFonts))
         {
            _loc1_ = false;
            for each(_loc2_ in embeddedFonts)
            {
               if(_font == _loc2_.fontName)
               {
                  _loc1_ = true;
                  break;
               }
            }
            field.embedFonts = _loc1_;
            if(!_loc1_)
            {
               trace("WARNING: Embedded font \'" + _font + "\' not found, disabling embedding of fonts, text = " + _text);
            }
            else
            {
               trace("Found Embedded font \'" + _font + "\' using font");
            }
         }
         else
         {
            field.embedFonts = false;
         }
         if(Boolean(TextFieldFit.forceFont))
         {
            format.font = TextFieldFit.forceFont;
         }
         else
         {
            format.font = _font;
         }
         if(sizeChanged)
         {
            format.size = _textSize;
         }
         format.color = _textColor;
         format.align = _hAlign;
         format.bold = _bold;
         format.italic = _italic;
         format.underline = _underline;
         format.leftMargin = 0;
         format.rightMargin = 0;
         field.setTextFormat(format);
         if(_useGlowFilter)
         {
            filters = [new GlowFilter(_glowColor,1,_glowBlur,_glowBlur,_glowStrength,_glowQuality)];
         }
         else
         {
            filters = [];
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         w = param1;
         h = param2;
         scaleX = scaleY = 1;
         field.width = w;
         field.height = h;
         invalidate();
      }
      
      private function layoutText() : void
      {
         resizeText();
         field.height = field.textHeight + gutter * 2;
         if(vAlign == "top")
         {
            field.y = 0;
         }
         else if(vAlign == "middle")
         {
            field.y = (h - field.height) / 2;
         }
         else if(vAlign == "bottom")
         {
            field.y = h - field.height;
         }
      }
      
      private function resizeText(param1:Boolean = false) : void
      {
         if(!doesTextFit())
         {
            format.size = Object(Number(format.size) - 1);
            if(format.size <= 3)
            {
               trace("WARNING: Text resised to 3px, either an error occured or the text just wont fit");
               return;
            }
            field.setTextFormat(format);
            resizeText(true);
         }
         else if(param1 == false)
         {
            while(doesTextFit())
            {
               if(format.size > textSize)
               {
                  break;
               }
               format.size = Object(Number(format.size) + 1);
               field.setTextFormat(format);
               if(!doesTextFit())
               {
                  format.size = Object(Number(format.size) - 1);
                  field.setTextFormat(format);
                  break;
               }
            }
         }
      }
      
      private function doesTextFit() : Boolean
      {
         if(field.textHeight + gutter * 2 > h || field.textWidth + gutter * 2 > w && (!field.multiline || alwaysCheckWidth))
         {
            return false;
         }
         return true;
      }
      
      private function invalidate() : void
      {
         if(valid)
         {
            addEventListener(Event.ENTER_FRAME,validate);
            if(Boolean(stage))
            {
               stage.invalidate();
            }
            valid = false;
         }
      }
      
      private function validate(param1:Event = null) : void
      {
         updateProperties();
         layoutText();
         removeEventListener(Event.ENTER_FRAME,validate);
         valid = true;
      }
      
      [Inspectable(name="  Text",defaultValue="Text")]
      public function set text(param1:String) : void
      {
         _text = param1;
         invalidate();
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      [Inspectable(name="  Text Color",type="Color")]
      public function set textColor(param1:uint) : void
      {
         _textColor = param1;
         invalidate();
      }
      
      public function get textColor() : uint
      {
         return _textColor;
      }
      
      [Inspectable(name="  Text Size",defaultValue="12")]
      public function set textSize(param1:Number) : void
      {
         _textSize = param1;
         sizeChanged = true;
         invalidate();
      }
      
      public function get textSize() : Number
      {
         return _textSize;
      }
      
      [Inspectable(name=" Multi Line",defaultValue="false")]
      public function set multiline(param1:Boolean) : void
      {
         _multiline = param1;
         invalidate();
      }
      
      public function get multiline() : Boolean
      {
         return _multiline;
      }
      
      [Inspectable(name=" Disable Wordwrap",defaultValue="false")]
      public function set disableWordwrap(param1:Boolean) : void
      {
         _disableWordwrap = param1;
         invalidate();
      }
      
      public function get disableWordwrap() : Boolean
      {
         return _disableWordwrap;
      }
      
      [Inspectable(name=" Horizontal Align",type="list",enumeration="left, center, right",defaultValue="left")]
      public function set hAlign(param1:String) : void
      {
         _hAlign = param1;
         invalidate();
      }
      
      public function get hAlign() : String
      {
         return _hAlign;
      }
      
      [Inspectable(name=" Vertical Align",type="list",enumeration="top, middle, bottom",defaultValue="top")]
      public function set vAlign(param1:String) : void
      {
         _vAlign = param1;
         invalidate();
      }
      
      public function get vAlign() : String
      {
         return _vAlign;
      }
      
      [Inspectable(name=" Bold",defaultValue="false")]
      public function set bold(param1:Boolean) : void
      {
         _bold = param1;
         invalidate();
      }
      
      public function get bold() : Boolean
      {
         return _bold;
      }
      
      [Inspectable(name="Underline",defaultValue="false")]
      public function set underline(param1:Boolean) : void
      {
         _underline = param1;
         invalidate();
      }
      
      public function get underline() : Boolean
      {
         return _underline;
      }
      
      [Inspectable(name="Italic",defaultValue="false")]
      public function set italic(param1:Boolean) : void
      {
         _italic = param1;
         invalidate();
      }
      
      public function get italic() : Boolean
      {
         return _italic;
      }
      
      [Inspectable(name="Selectable",defaultValue="false")]
      public function set selectable(param1:Boolean) : void
      {
         _selectable = param1;
         invalidate();
      }
      
      public function get selectable() : Boolean
      {
         return _selectable;
      }
      
      [Inspectable(name=" Font",defaultValue="")]
      public function set font(param1:String) : void
      {
         _font = param1;
         invalidate();
      }
      
      public function get font() : String
      {
         return _font;
      }
      
      [Inspectable(name=" Embed Fonts",defaultValue="true")]
      public function set embedFonts(param1:Boolean) : void
      {
         _embedFonts = param1;
         invalidate();
      }
      
      public function get embedFonts() : Boolean
      {
         return _embedFonts;
      }
      
      [Inspectable(name="Anti Alias Type",enumeration="normal, advanced",defaultValue="advanced")]
      public function set antiAliasType(param1:String) : void
      {
         _antiAliasType = param1;
         invalidate();
      }
      
      public function get antiAliasType() : String
      {
         return _antiAliasType;
      }
      
      [Inspectable(name="Grid Fit Type",enumeration="none, pixel, subpixel",defaultValue="pixel")]
      public function set gridFitType(param1:String) : void
      {
         _gridFitType = param1;
         invalidate();
      }
      
      public function get gridFitType() : String
      {
         return _gridFitType;
      }
      
      [Inspectable(name="Glow Filter",defaultValue="false")]
      public function set useGlowFilter(param1:Boolean) : void
      {
         _useGlowFilter = param1;
         invalidate();
      }
      
      public function get useGlowFilter() : Boolean
      {
         return _useGlowFilter;
      }
      
      [Inspectable(name="Glow Blur",defaultValue="3")]
      public function set glowBlur(param1:Number) : void
      {
         _glowBlur = param1;
         invalidate();
      }
      
      public function get glowBlur() : Number
      {
         return _glowBlur;
      }
      
      [Inspectable(name="Glow Color",type="Color")]
      public function set glowColor(param1:uint) : void
      {
         _glowColor = param1;
         invalidate();
      }
      
      public function get glowColor() : uint
      {
         return _glowColor;
      }
      
      [Inspectable(name="Glow Strength",type="Number",defaultValue="5")]
      public function set glowStrength(param1:Number) : void
      {
         _glowStrength = param1;
         invalidate();
      }
      
      public function get glowStrength() : Number
      {
         return _glowStrength;
      }
      
      [Inspectable(name="Glow Quality",type="Number",defaultValue="1")]
      public function set glowQuality(param1:Number) : void
      {
         _glowQuality = param1;
         invalidate();
      }
      
      public function get glowQuality() : Number
      {
         return _glowQuality;
      }
   }
}

