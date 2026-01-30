package entities
{
   import flash.display.Sprite;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   
   public class HealthBarEntity extends Entity
   {
      
      private var health_bars:Array = new Array();
      
      public function HealthBarEntity()
      {
         super();
         this.layer = Const.HEALTH_BAR_LAYER;
      }
      
      override public function render() : void
      {
         var s:Sprite = null;
         super.render();
         for each(s in this.health_bars)
         {
            FP.buffer.draw(s);
         }
      }
      
      override public function added() : void
      {
         this.health_bars = new Array();
      }
      
      override public function removed() : void
      {
         this.health_bars = null;
      }
      
      public function add(s:Sprite) : void
      {
         this.health_bars.push(s);
      }
      
      public function remove(s:Sprite) : void
      {
         for(var i:int = 0; i < this.health_bars.length; i++)
         {
            if(this.health_bars[i] == s)
            {
               this.health_bars.splice(i,1);
               return;
            }
         }
      }
   }
}

