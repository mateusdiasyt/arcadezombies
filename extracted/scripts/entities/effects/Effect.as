package entities.effects
{
   import entities.TowerEntity;
   
   public class Effect
   {
      
      public static const FIRE:int = 0;
      
      public static const ICE:int = 1;
      
      public static const POISON:int = 2;
      
      public static const STUN:int = 3;
      
      public var type:int;
      
      public var rank:int = 0;
      
      public var tower:TowerEntity;
      
      public var damage:Number = 0;
      
      public var period:Number = 0;
      
      public var duration:Number = 0;
      
      public var damage_at_end:Boolean = false;
      
      public var slow_percent:Number = 0;
      
      private var timer:Number = 0;
      
      public var ignoreArmor:Boolean = false;
      
      public function Effect(type:int, tower:TowerEntity, rank:int, damage:Number, time:Number, slow_percent:Number, damage_at_end:Boolean = false, ignoreArmor:Boolean = false)
      {
         super();
         this.type = type;
         this.rank = 0;
         this.tower = tower;
         this.ignoreArmor = ignoreArmor;
         this.damage_at_end = damage_at_end;
         if(!this.damage_at_end)
         {
            this.damage = damage / time;
         }
         else
         {
            this.damage = damage;
         }
         this.period = 1;
         this.duration = time;
         this.slow_percent = slow_percent;
      }
      
      public function expired() : Boolean
      {
         if(this.duration <= 0)
         {
            return true;
         }
         return false;
      }
      
      public function checkTick(t:Number) : Boolean
      {
         this.timer += t;
         this.duration -= t;
         if(this.timer > this.period)
         {
            this.timer = 0;
            return true;
         }
         return false;
      }
      
      public function resolve(e:Effect) : void
      {
         if(e.rank > this.rank)
         {
            this.damage = e.damage;
            this.period = e.period;
            this.duration = e.duration;
            this.slow_percent = e.slow_percent;
            this.tower = e.tower;
         }
         else
         {
            this.duration = e.duration;
         }
      }
   }
}

