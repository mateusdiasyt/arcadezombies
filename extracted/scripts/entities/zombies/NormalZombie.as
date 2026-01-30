package entities.zombies
{
   import entities.ZombieEntity;
   
   public class NormalZombie extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.difficulty_normal;
      
      public static const PORTRAIT_INDEX:int = 0;
      
      public function NormalZombie(level:Number = 1, modifier:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 48 * 0.8;
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
         this.score = 1 * modifier;
         if(this.score < 1)
         {
            this.score = 1;
         }
         this.bounty = Math.floor(Math.pow(this.level,0.46));
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
         image.add(Const.WALK,[0,1,2,3],3);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[0 + 60,1 + 60,2 + 60,3 + 60],3);
         this.hittable = true;
         image.add(Const.HIT1,[4,5,1,1,1],8);
         image.add(Const.HIT2,[5,4,1,1,1],8);
         image.add(Const.FROZEN_HIT1,[4 + 60,5 + 60,1 + 60,1 + 60,1 + 60],8);
         image.add(Const.FROZEN_HIT2,[5 + 60,4 + 60,1 + 60,1 + 60,1 + 60],8);
      }
   }
}

