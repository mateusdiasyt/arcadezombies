package entities.zombies
{
   import entities.ZombieEntity;
   
   public class HellHound extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_hound;
      
      public static const PORTRAIT_INDEX:int = 9;
      
      public function HellHound(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 84 * 0.8;
         this.health = 18 * modifier;
         this.total_health = 18 * modifier;
         this.armor = 0;
         if(modifier >= 6)
         {
            this.armor = 0.17 * modifier;
         }
         if(this.armor > 5)
         {
            this.armor = 5;
         }
         this.score = 2 * modifier;
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
         this.invisible = false;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.gl.add(image);
         this.graphic = gl;
         image.add(Const.WALK,[18,19,20,21],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[18 + 60,19 + 60,20 + 60,21 + 60],5);
         this.hittable = true;
         image.add(Const.HIT1,[22,23,18,18,18],8);
         image.add(Const.HIT2,[23,22,18,18,18],8);
         image.add(Const.FROZEN_HIT1,[22 + 60,23 + 60,18 + 60,18 + 60,18 + 60],8);
         image.add(Const.FROZEN_HIT2,[23 + 60,22 + 60,18 + 60,18 + 60,18 + 60],8);
      }
   }
}

