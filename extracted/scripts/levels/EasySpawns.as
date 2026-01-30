package levels
{
   import entities.zombies.DevilishBoss;
   import entities.zombies.FemaleZombie;
   import entities.zombies.FlyingZombie;
   import entities.zombies.HammerTimeBoss;
   import entities.zombies.HellHound;
   import entities.zombies.InvisibleZombie;
   import entities.zombies.NormalZombie;
   import entities.zombies.ProjectXBoss;
   import entities.zombies.StrongZombie;
   import entities.zombies.TorsoZombie;
   
   public class EasySpawns extends Levels
   {
      
      public function EasySpawns()
      {
         super();
         between_levels = 30;
         max_level = 50;
         waves = [new Wave(1,10,NormalZombie,0.5),new Wave(2,10,FemaleZombie,0.6),new Wave(3,6,StrongZombie,0.7,1.5),new Wave(4,10,FlyingZombie,0.8),new Wave(5,10,NormalZombie,0.9),new Wave(6,10,HellHound,1),new Wave(7,8,TorsoZombie,1.2),new Wave(8,10,InvisibleZombie,1.5),new Wave(9,10,FemaleZombie,1.7),new Wave(10,1,HammerTimeBoss,0.5),new Wave(11,10,NormalZombie,2),new Wave(12,10,FemaleZombie,2.4),new Wave(13,6,StrongZombie,2.7,1.5),new Wave(14,10,FlyingZombie,3),new Wave(15,10,NormalZombie,3.3),new Wave(16,10,HellHound,3.5),new Wave(17,8,TorsoZombie,3.7),new Wave(18,10,InvisibleZombie,3.9),new Wave(19,10,FemaleZombie,4.1),new Wave(20,1,ProjectXBoss,1.5),new Wave(21,10,NormalZombie,4.3),new Wave(22,10,FemaleZombie,4.5),new Wave(23,6,StrongZombie,5,1.5),new Wave(24,10,FlyingZombie,6),new Wave(25,10,NormalZombie,6.5),new Wave(26,10,HellHound,7),new Wave(27,8,TorsoZombie,7.4),new Wave(28,10,InvisibleZombie,8),new Wave(29,10,FemaleZombie,8.6),new Wave(30,1,DevilishBoss,3.5),new Wave(31,10,NormalZombie
         ,9.2),new Wave(32,10,FemaleZombie,9.8),new Wave(33,6,StrongZombie,10.4,1.5),new Wave(34,10,FlyingZombie,11),new Wave(35,10,NormalZombie,12),new Wave(36,10,HellHound,13),new Wave(37,8,TorsoZombie,14),new Wave(38,10,InvisibleZombie,15),new Wave(39,10,FemaleZombie,16),new Parade(40,3,4,3),new Wave(41,10,NormalZombie,18),new Wave(42,10,FemaleZombie,20),new Wave(43,6,StrongZombie,22,1.5),new Wave(44,10,FlyingZombie,24),new Wave(45,10,NormalZombie,26),new Wave(46,10,HellHound,28),new Wave(47,8,TorsoZombie,30),new Wave(48,10,InvisibleZombie,32),new Wave(49,10,FemaleZombie,34),new Parade(50,6,6,3)];
      }
   }
}

