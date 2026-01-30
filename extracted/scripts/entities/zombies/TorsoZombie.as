package entities.zombies
{
   import entities.ZombieEntity;
   
   public class TorsoZombie extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_torso;
      
      public static const PORTRAIT_INDEX:int = 18;
      
      public function TorsoZombie(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 46 * 0.8;
         this.health = 25 * modifier;
         this.total_health = 25 * modifier;
         this.armor = 1 * Math.sqrt(modifier);
         if(this.armor > 14)
         {
            this.armor = 14;
         }
         this.score = 1.5 * modifier;
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
         image.add(Const.WALK,[36,37,38,39],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[36 + 60,37 + 60,38 + 60,39 + 60],5);
         this.hittable = true;
         image.add(Const.HIT1,[40,41,36,36,36],8);
         image.add(Const.HIT2,[41,40,36,36,36],8);
         image.add(Const.FROZEN_HIT1,[40 + 60,41 + 60,36 + 60,36 + 60,36 + 60],8);
         image.add(Const.FROZEN_HIT2,[41 + 60,40 + 60,36 + 60,36 + 60,36 + 60],8);
      }
   }
}

