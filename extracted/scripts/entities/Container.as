package entities
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.Graphic;
   import net.flashpunk.utils.Input;
   
   public class Container extends Button
   {
      
      protected var children:Vector.<Entity> = new Vector.<Entity>();
      
      protected var removeable:Boolean = true;
      
      public function Container(removeable:Boolean = true)
      {
         super();
         this.layer = FP.world.layerNearest - 1;
         this.removeable = removeable;
      }
      
      public function add(toAdd:*, x:Number = 0, y:Number = 0, layer:int = 1) : Entity
      {
         var e:Entity = null;
         if(toAdd is Entity)
         {
            e = toAdd;
         }
         else
         {
            if(!(toAdd is Graphic))
            {
               throw new Error(toAdd + " is not a supported class type");
            }
            e = new Entity(0,0,toAdd);
         }
         e.x = this.x + x;
         e.y = this.y + y;
         e.layer = this.layer - layer;
         this.children.push(e);
         if(this.world == FP.world)
         {
            FP.world.add(e);
         }
         return e;
      }
      
      override public function update() : void
      {
         if(this.removeable && Input.mousePressed && !collidePoint(this.x,this.y,Input.mouseX,Input.mouseY))
         {
            FP.world.remove(this);
         }
         super.update();
      }
      
      public function remove(toRemove:Entity) : void
      {
         for(var i:int = 0; i < this.children.length; i++)
         {
            if(this.children[i] == toRemove)
            {
               if(FP.world == toRemove.world)
               {
                  FP.world.remove(toRemove);
               }
               this.children.splice(i,1);
               return;
            }
         }
      }
      
      public function removeAll() : void
      {
         var e:Entity = null;
         for each(e in this.children)
         {
            FP.world.remove(e);
         }
         this.children.length = 0;
      }
      
      override public function added() : void
      {
         var child:Entity = null;
         for each(child in this.children)
         {
            FP.world.add(child);
         }
      }
      
      override public function removed() : void
      {
         var child:Entity = null;
         for each(child in this.children)
         {
            if(FP.world == child.world)
            {
               FP.world.remove(child);
            }
         }
         this.children.length = 0;
      }
   }
}

