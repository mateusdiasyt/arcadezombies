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
   
   public class HardSpawns extends Levels
   {
      
      public function HardSpawns()
      {
         super();
         between_levels = 30;
         max_level = 70;
         waves = [new Wave(1,10,NormalZombie,0.6),new Wave(2,10,FemaleZombie,0.7),new Wave(3,6,StrongZombie,0.8,1.5),new Wave(4,10,FlyingZombie,0.9),new Wave(5,10,NormalZombie,1),new Wave(6,10,HellHound,1.2),new Wave(7,8,TorsoZombie,1.4),new Wave(8,10,InvisibleZombie,1.7),new Wave(9,10,FemaleZombie,2),new Wave(10,1,HammerTimeBoss,0.6),new Wave(11,10,NormalZombie,2.4),new Wave(12,10,FemaleZombie,2.8),new Wave(13,6,StrongZombie,3.1,1.5),new Wave(14,10,FlyingZombie,3.4),new Wave(15,10,NormalZombie,3.8),new Wave(16,10,HellHound,4.1),new Wave(17,8,TorsoZombie,4.4),new Wave(18,10,InvisibleZombie,4.7),new Wave(19,10,FemaleZombie,4.9),new Wave(20,1,ProjectXBoss,2),new Wave(21,10,NormalZombie,5.2),new Wave(22,10,FemaleZombie,5.5),new Wave(23,6,StrongZombie,6.1,1.5),new Wave(24,10,FlyingZombie,7),new Wave(25,10,NormalZombie,7.7),new Wave(26,10,HellHound,8.4),new Wave(27,8,TorsoZombie,7.4),new Wave(28,10,InvisibleZombie,8),new Wave(29,10,FemaleZombie,8.6),new Wave(30,1,DevilishBoss,4.2),new Wave(31,10,NormalZombie
         ,9),new Wave(32,10,FemaleZombie,10),new Wave(33,6,StrongZombie,11,1.5),new Wave(34,10,FlyingZombie,12),new Wave(35,10,NormalZombie,13),new Wave(36,10,HellHound,14),new Wave(37,8,TorsoZombie,15),new Wave(38,10,InvisibleZombie,16),new Wave(39,10,FemaleZombie,17),new Parade(40,3,4.3,3),new Wave(41,10,NormalZombie,18),new Wave(42,10,FemaleZombie,20),new Wave(43,6,StrongZombie,22,1.5),new Wave(44,10,FlyingZombie,24),new Wave(45,10,NormalZombie,26),new Wave(46,10,HellHound,28),new Wave(47,8,TorsoZombie,30),new Wave(48,10,InvisibleZombie,32),new Wave(49,10,FemaleZombie,34),new Parade(50,6,8,3),new Wave(51,10,NormalZombie,35),new Wave(52,10,FemaleZombie,36),new Wave(53,6,StrongZombie,37,1.5),new Wave(54,10,FlyingZombie,38),new Wave(55,10,NormalZombie,40),new Wave(56,10,HellHound,42),new Wave(57,8,TorsoZombie,44),new Wave(58,10,InvisibleZombie,46),new Wave(59,10,FemaleZombie,48),new Parade(60,9,10,2.25),new Wave(61,10,NormalZombie,50),new Wave(62,10,FemaleZombie,52),new Wave(63,6,StrongZombie,56
         ,1.5),new Wave(64,10,FlyingZombie,60),new Wave(65,10,NormalZombie,64),new Wave(66,10,HellHound,68),new Wave(67,8,TorsoZombie,72),new Wave(68,10,InvisibleZombie,76),new Wave(69,10,FemaleZombie,80),new Parade(70,12,15,1.75)];
      }
   }
}

