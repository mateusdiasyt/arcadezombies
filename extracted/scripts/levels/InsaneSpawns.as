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
   
   public class InsaneSpawns extends Levels
   {
      
      public function InsaneSpawns()
      {
         super();
         between_levels = 30;
         max_level = 80;
         waves = [new Wave(1,10,NormalZombie,0.6 * 1),new Wave(2,10,FemaleZombie,0.7 * 1),new Wave(3,6,StrongZombie,0.8 * 1,1.5),new Wave(4,10,FlyingZombie,0.9 * 1),new Wave(5,10,NormalZombie,1 * 1),new Wave(6,10,HellHound,1.1 * 1),new Wave(7,8,TorsoZombie,1.3 * 1),new Wave(8,10,InvisibleZombie,1.7 * 1),new Wave(9,10,FemaleZombie,1.9 * 1),new Wave(10,1,HammerTimeBoss,0.5 * 1),new Wave(11,10,NormalZombie,2 * 1),new Wave(12,10,FemaleZombie,2.4 * 1),new Wave(13,6,StrongZombie,2.7 * 1,1.5),new Wave(14,10,FlyingZombie,3 * 1),new Wave(15,10,NormalZombie,3.3 * 1),new Wave(16,10,HellHound,3.5 * 1),new Wave(17,8,TorsoZombie,3.7 * 1),new Wave(18,10,InvisibleZombie,3.9 * 1),new Wave(19,10,FemaleZombie,4.1 * 1),new Wave(20,1,ProjectXBoss,1.5 * 1),new Wave(21,10,NormalZombie,4.3 * 1),new Wave(22,10,FemaleZombie,4.5 * 1),new Wave(23,6,StrongZombie,5 * 1,1.5),new Wave(24,10,FlyingZombie,6 * 1),new Wave(25,10,NormalZombie,6.5 * 1),new Wave(26,10,HellHound,7 * 1),new Wave(27,8,TorsoZombie,7.4 * 1),new Wave(28,10
         ,InvisibleZombie,8 * 1),new Wave(29,10,FemaleZombie,8.6 * 1),new Wave(30,1,DevilishBoss,3.5 * 1),new Wave(31,10,NormalZombie,9.2 * 1),new Wave(32,10,FemaleZombie,9.8 * 1),new Wave(33,6,StrongZombie,10.4 * 1,1.5),new Wave(34,10,FlyingZombie,11 * 1),new Wave(35,10,NormalZombie,12 * 1),new Wave(36,10,HellHound,13 * 1),new Wave(37,8,TorsoZombie,14 * 1),new Wave(38,10,InvisibleZombie,15 * 1),new Wave(39,10,FemaleZombie,16 * 1),new Parade(40,3,4 * 1,3),new Wave(41,10,NormalZombie,18 * 1),new Wave(42,10,FemaleZombie,20 * 1),new Wave(43,6,StrongZombie,22 * 1,1.5),new Wave(44,10,FlyingZombie,24 * 1),new Wave(45,10,NormalZombie,26 * 1),new Wave(46,10,HellHound,28 * 1),new Wave(47,8,TorsoZombie,30 * 1),new Wave(48,10,InvisibleZombie,32 * 1),new Wave(49,10,FemaleZombie,34 * 1),new Parade(50,6,6 * 1,3),new Wave(51,10,NormalZombie,36 * 1),new Wave(52,10,FemaleZombie,40 * 1),new Wave(53,6,StrongZombie,44 * 1,1.5),new Wave(54,10,FlyingZombie,48 * 1),new Wave(55,10,NormalZombie,52 * 1),new Wave(56,10,HellHound
         ,56 * 1),new Wave(57,8,TorsoZombie,60 * 1),new Wave(58,10,InvisibleZombie,66 * 1),new Wave(59,10,FemaleZombie,72 * 1),new Parade(60,9,9 * 1,2.25),new Wave(61,10,NormalZombie,76 * 1),new Wave(62,10,FemaleZombie,80 * 1),new Wave(63,6,StrongZombie,85 * 1,1.5),new Wave(64,10,FlyingZombie,90 * 1),new Wave(65,10,NormalZombie,95 * 1),new Wave(66,10,HellHound,100 * 1),new Wave(67,8,TorsoZombie,110 * 1),new Wave(68,10,InvisibleZombie,120 * 1),new Wave(69,10,FemaleZombie,130 * 1),new Parade(70,12,15 * 1,1.75),new Wave(71,10,NormalZombie,135 * 1),new Wave(72,10,FemaleZombie,147 * 1),new Wave(73,6,StrongZombie,160 * 1,1.5),new Wave(74,10,FlyingZombie,170 * 1),new Wave(75,10,NormalZombie,180 * 1),new Wave(76,10,HellHound,190 * 1),new Wave(77,8,TorsoZombie,200 * 1),new Wave(78,10,InvisibleZombie,210 * 1),new Wave(79,10,FemaleZombie,220 * 1),new Parade(80,15,25 * 1,1.5)];
      }
   }
}

