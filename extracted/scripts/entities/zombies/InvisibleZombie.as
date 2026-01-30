package entities.zombies
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import net.flashpunk.FP;
   
   public class InvisibleZombie extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_invisible;
      
      public static const PORTRAIT_INDEX:int = 12;
      
      public function InvisibleZombie(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 42 * 0.8;
         this.health = 20 * modifier;
         this.total_health = 20 * modifier;
         this.armor = 0;
         if(modifier >= 6)
         {
            this.armor = 0.17 * modifier;
         }
         if(this.armor > 10)
         {
            this.armor = 10;
         }
         this.score = 1.5 * modifier;
         if(this.score < 1)
         {
            this.score = 1;
         }
         this.bounty = Math.floor(Math.pow(this.level,0.46)) + Math.ceil(level / 20);
         if(this.level > 40)
         {
            this.bounty += Math.pow(this.level - 40,0.5);
         }
         this.flying = false;
         this.invisible = true;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.gl.add(image);
         this.graphic = gl;
         image.add(Const.WALK,[24,25,26,27],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[24 + 60,25 + 60,26 + 60,27 + 60],5);
         this.hittable = true;
         image.add(Const.HIT1,[28,29,24,24,24],8);
         image.add(Const.HIT2,[29,28,24,24,24],8);
         image.add(Const.FROZEN_HIT1,[28 + 60,29 + 60,24 + 60,24 + 60,24 + 60],8);
         image.add(Const.FROZEN_HIT2,[29 + 60,28 + 60,24 + 60,24 + 60,24 + 60],8);
         image.alpha = 0.2;
      }
      
      override public function update() : void
      {
         this.cyclevisible();
         super.update();
      }
      
      override public function get isvisible() : Boolean
      {
         if(image.alpha > 0.4)
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
               image.alpha = 0.5;
               return;
            }
         }
         image.alpha = 0.2;
      }
   }
}

