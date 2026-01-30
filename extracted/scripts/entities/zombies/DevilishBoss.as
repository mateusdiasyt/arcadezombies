package entities.zombies
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import net.flashpunk.FP;
   
   public class DevilishBoss extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_devilish;
      
      public static const PORTRAIT_INDEX:int = 27;
      
      public function DevilishBoss(level:Number = 1, modifier:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 36 * 0.8;
         this.health = 450 * modifier;
         this.total_health = 450 * modifier;
         this.armor = 2 * Math.sqrt(modifier);
         if(this.armor > 28)
         {
            this.armor = 28;
         }
         this.invisible = true;
         this.flying = true;
         this.score = 20 * modifier;
         if(this.score < 1)
         {
            this.score = 1;
         }
         this.bounty = 10 + Math.floor(this.level / 10) * 10;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.gl.add(image);
         this.graphic = gl;
         image.add(Const.WALK,[54,55,56,57],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[54 + 60,55 + 60,56 + 60,57 + 60],5);
         this.image.alpha = 0.3;
         this.hittable = true;
         image.add(Const.HIT1,[58,59,54,54,54],8);
         image.add(Const.HIT2,[59,58,54,54,54],8);
         image.add(Const.FROZEN_HIT1,[58 + 60,59 + 60,54 + 60,54 + 60,54 + 60],8);
         image.add(Const.FROZEN_HIT2,[59 + 60,58 + 60,54 + 60,54 + 60,54 + 60],8);
      }
      
      override public function update() : void
      {
         this.cyclevisible();
         super.update();
      }
      
      override public function get isvisible() : Boolean
      {
         if(image.alpha > 0.5)
         {
            return true;
         }
         return false;
      }
      
      private function cyclevisible() : void
      {
         var t:TowerEntity = null;
         var sentry:Array = new Array();
         FP.world.getType("SensorTower",sentry);
         for each(t in sentry)
         {
            if(t.placed && t.distance(this.centerX,this.centerY) - 10 <= t.range)
            {
               image.alpha = 0.7;
               return;
            }
         }
         image.alpha = 0.3;
      }
   }
}

