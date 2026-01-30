package entities.menu
{
   import entities.Container;
   import net.flashpunk.graphics.Text;
   
   public class TimeLineMenuHover extends Container
   {
      
      private var name:String;
      
      private var count:Number;
      
      public function TimeLineMenuHover(name:String, count:Number)
      {
         super();
         this.name = name;
         this.count = count;
         this.x = 510;
         this.y = 317;
         if(Const.FONT == "Blah")
         {
            this.y += 2;
         }
      }
      
      override public function added() : void
      {
         Text.size = 11 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         var t:Text = new Text(this.count + " : " + this.name);
         t.color = 0;
         add(t,0,0);
      }
   }
}

