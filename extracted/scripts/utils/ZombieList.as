package utils
{
   import entities.ZombieEntity;
   
   public class ZombieList
   {
      
      private var zombies:Array = new Array();
      
      public function ZombieList()
      {
         super();
      }
      
      public function add(z:ZombieEntity) : void
      {
         this.zombies.push(z);
      }
      
      public function getZombie(i:int) : ZombieEntity
      {
         return this.zombies[i];
      }
      
      public function getList() : Array
      {
         return this.zombies;
      }
      
      public function getZombies(x:Number, y:Number, range:Number, getInvisible:Boolean = false) : Array
      {
         var z:ZombieEntity = null;
         var list:Array = new Array();
         for each(z in this.distanceTo(x,y,range))
         {
            if(getInvisible || z.isvisible)
            {
               list.push(z);
            }
         }
         return list;
      }
      
      public function getGround(x:Number, y:Number, range:Number, getInvisible:Boolean = false) : Array
      {
         var z:ZombieEntity = null;
         var list:Array = new Array();
         for each(z in this.distanceTo(x,y,range))
         {
            if(!z.flying && (getInvisible || z.isvisible))
            {
               list.push(z);
            }
         }
         return list;
      }
      
      public function getFlying(x:Number, y:Number, range:Number, getInvisible:Boolean = false) : Array
      {
         var z:ZombieEntity = null;
         var list:Array = new Array();
         for each(z in this.distanceTo(x,y,range))
         {
            if(z.flying && (getInvisible || z.isvisible))
            {
               list.push(z);
            }
         }
         return list;
      }
      
      public function get length() : int
      {
         return this.zombies.length;
      }
      
      public function remove(z:ZombieEntity) : void
      {
         for(var i:int = 0; i < this.zombies.length; i++)
         {
            if(z == this.zombies[i])
            {
               this.zombies.splice(i,1);
               return;
            }
         }
      }
      
      public function distanceTo(x:Number, y:Number, dist:Number) : Array
      {
         var t:Array = new Array();
         for(var i:int = 0; i < this.zombies.length; i++)
         {
            if(this.distance(this.zombies[i],x,y) - 15 < dist)
            {
               t.push(this.zombies[i]);
            }
         }
         return t;
      }
      
      public function distance(z:ZombieEntity, x:Number, y:Number) : Number
      {
         var dx:Number = z.centerX - x;
         var dy:Number = z.centerY - y;
         return Math.sqrt(dx * dx + dy * dy);
      }
      
      public function reOrder() : void
      {
         this.zombies.sortOn("distanceToEnd",Array.NUMERIC);
      }
   }
}

