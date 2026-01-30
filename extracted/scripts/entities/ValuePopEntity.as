package entities
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Text;
   
   public class ValuePopEntity extends Entity
   {
      
      public static var pool:Array = new Array();
      
      private var valueText:Text;
      
      private var value:int;
      
      private var color:uint;
      
      private var text_x:Number;
      
      private var text_y:Number;
      
      private var ol1:Text;
      
      private var ol2:Text;
      
      private var ol3:Text;
      
      private var ol4:Text;
      
      private var startY:Number = 0;
      
      private var _active:Boolean = false;
      
      public function ValuePopEntity()
      {
         super();
         this.layer = Const.VALUE_POP_LAYER;
      }
      
      public static function create(value:int, x:Number, y:Number, color:uint = 16763904) : ValuePopEntity
      {
         var i:int = 0;
         if(pool.length == 0)
         {
            for(i = 0; i < 5; i++)
            {
               pool[i] = new ValuePopEntity();
            }
         }
         var v:ValuePopEntity = pool.splice(0,1)[0];
         v.setup(value,x,y,color);
         return v;
      }
      
      public function setup(value:int, x:Number, y:Number, color:uint = 16763904) : void
      {
         this._active = true;
         this.value = value;
         this.color = color;
         this.text_x = x;
         this.text_y = y;
         this.startY = y;
      }
      
      public function recycle() : void
      {
         if(this._active)
         {
            this._active = false;
            ValuePopEntity.pool.push(this);
            FP.world.remove(this);
         }
      }
      
      override public function added() : void
      {
         Text.size = 16 / Const.FONT_OFFSET;
         Text.font = Const.FONT;
         this.valueText = new Text("+" + this.value,this.text_x,this.text_y);
         this.valueText.x -= this.valueText.width / 2;
         this.valueText.color = this.color;
         this.ol1 = new Text(this.valueText.text,0,0);
         this.ol1.color = 0;
         this.ol1.x = this.valueText.x - 1;
         this.ol1.y = this.valueText.y - 1;
         this.ol2 = new Text(this.valueText.text,0,0);
         this.ol2.color = 0;
         this.ol2.x = this.valueText.x - 1;
         this.ol2.y = this.valueText.y + 1;
         this.ol3 = new Text(this.valueText.text,0,0);
         this.ol3.color = 0;
         this.ol3.x = this.valueText.x + 1;
         this.ol3.y = this.valueText.y - 1;
         this.ol4 = new Text(this.valueText.text,0,0);
         this.ol4.color = 0;
         this.ol4.x = this.valueText.x + 1;
         this.ol4.y = this.valueText.y + 1;
         this.graphic = new Graphiclist(this.ol1,this.ol2,this.ol3,this.ol4,this.valueText);
         super.added();
      }
      
      override public function removed() : void
      {
         this.valueText = null;
         this.ol1 = null;
         this.ol2 = null;
         this.ol3 = null;
         this.ol4 = null;
         this.graphic = null;
         super.removed();
      }
      
      override public function update() : void
      {
         if(this.valueText.y > this.startY - 20)
         {
            this.valueText.y -= 0.5;
            this.ol1.y -= 0.5;
            this.ol2.y -= 0.5;
            this.ol3.y -= 0.5;
            this.ol4.y -= 0.5;
         }
         else
         {
            this.recycle();
         }
      }
   }
}

