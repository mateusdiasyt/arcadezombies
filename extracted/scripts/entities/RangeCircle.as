package entities
{
   import flash.display.Sprite;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   
   public class RangeCircle extends Entity
   {
      
      private var circles:Array = new Array();
      
      public function RangeCircle()
      {
         super();
         this.layer = Const.RANGE_CIRLCE_LAYER;
      }
      
      override public function render() : void
      {
         var s:Sprite = null;
         super.render();
         for each(s in this.circles)
         {
            FP.buffer.draw(s);
         }
      }
      
      override public function added() : void
      {
         this.circles = new Array();
      }
      
      override public function removed() : void
      {
         this.circles = null;
      }
      
      public function add(s:Sprite) : void
      {
         this.circles.push(s);
      }
      
      public function remove(s:Sprite) : void
      {
         for(var i:int = 0; i < this.circles.length; i++)
         {
            if(this.circles[i] == s)
            {
               this.circles.splice(i,1);
               return;
            }
         }
      }
   }
}

