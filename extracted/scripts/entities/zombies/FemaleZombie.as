package entities.zombies
{
   import entities.ZombieEntity;
   
   public class FemaleZombie extends ZombieEntity
   {
      
      public static const PORTRAIT_INDEX:int = 6;
      
      public static var NAME:String = Localizer.Instance.zombie_female;
      
      public function FemaleZombie(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 54 * 0.8;
         this.health = 25 * modifier;
         this.total_health = 25 * modifier;
         this.armor = 0;
         if(modifier >= 6)
         {
            this.armor = 0.17 * modifier;
         }
         if(this.armor > 10)
         {
            this.armor = 10;
         }
         this.score = 1.2 * modifier;
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
         image.add(Const.WALK,[12,13,14,15],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[12 + 60,13 + 60,14 + 60,15 + 60],5);
         this.hittable = true;
         image.add(Const.HIT1,[16,17,13,13,13],8);
         image.add(Const.HIT2,[17,16,13,13,13],8);
         image.add(Const.FROZEN_HIT1,[16 + 60,17 + 60,13 + 60,13 + 60,13 + 60],8);
         image.add(Const.FROZEN_HIT2,[17 + 60,16 + 60,13 + 60,13 + 60,13 + 60],8);
      }
      
      override public function playDeathSound() : void
      {
         SoundManager.playSound(Assets.SFX_GROWL_FEMALE);
      }
   }
}

