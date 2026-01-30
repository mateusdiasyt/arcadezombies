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
   
   public class NormalSpawns extends Levels
   {
      
      public function NormalSpawns()
      {
         super();
         between_levels = 30;
         max_level = 60;
         waves = [new Wave(1,10,NormalZombie,0.5 * 0.95),new Wave(2,10,FemaleZombie,0.6 * 0.95),new Wave(3,6,StrongZombie,0.7 * 0.95,1.5),new Wave(4,10,FlyingZombie,0.8 * 0.95),new Wave(5,10,NormalZombie,0.9 * 0.95),new Wave(6,10,HellHound,1 * 0.95),new Wave(7,8,TorsoZombie,1.2 * 0.95),new Wave(8,10,InvisibleZombie,1.5 * 0.95),new Wave(9,10,FemaleZombie,1.7 * 0.95),new Wave(10,1,HammerTimeBoss,0.5 * 0.95),new Wave(11,10,NormalZombie,2 * 0.95),new Wave(12,10,FemaleZombie,2.4 * 0.95),new Wave(13,6,StrongZombie,2.7 * 0.95,1.5),new Wave(14,10,FlyingZombie,3 * 0.95),new Wave(15,10,NormalZombie,3.3 * 0.95),new Wave(16,10,HellHound,3.5 * 0.95),new Wave(17,8,TorsoZombie,3.7 * 0.95),new Wave(18,10,InvisibleZombie,3.9 * 0.95),new Wave(19,10,FemaleZombie,4.1 * 0.95),new Wave(20,1,ProjectXBoss,1.5 * 0.95),new Wave(21,10,NormalZombie,4.3 * 0.95),new Wave(22,10,FemaleZombie,4.5 * 0.95),new Wave(23,6,StrongZombie,5 * 0.95,1.5),new Wave(24,10,FlyingZombie,6 * 0.95),new Wave(25,10,NormalZombie,6.5 * 0.95),new Wave(26
         ,10,HellHound,7 * 0.95),new Wave(27,8,TorsoZombie,7.4 * 0.95),new Wave(28,10,InvisibleZombie,8 * 0.95),new Wave(29,10,FemaleZombie,8.6 * 0.95),new Wave(30,1,DevilishBoss,3.5 * 0.95),new Wave(31,10,NormalZombie,9.2 * 0.95),new Wave(32,10,FemaleZombie,9.8 * 0.95),new Wave(33,6,StrongZombie,10.4 * 0.95,1.5),new Wave(34,10,FlyingZombie,11 * 0.95),new Wave(35,10,NormalZombie,12 * 0.95),new Wave(36,10,HellHound,13 * 0.95),new Wave(37,8,TorsoZombie,14 * 0.95),new Wave(38,10,InvisibleZombie,15 * 0.95),new Wave(39,10,FemaleZombie,16 * 0.95),new Parade(40,3,4 * 0.95,3),new Wave(41,10,NormalZombie,18 * 0.95),new Wave(42,10,FemaleZombie,20 * 0.95),new Wave(43,6,StrongZombie,22 * 0.95,1.5),new Wave(44,10,FlyingZombie,24 * 0.95),new Wave(45,10,NormalZombie,26 * 0.95),new Wave(46,10,HellHound,28 * 0.95),new Wave(47,8,TorsoZombie,30 * 0.95),new Wave(48,10,InvisibleZombie,32 * 0.95),new Wave(49,10,FemaleZombie,34 * 0.925),new Parade(50,6,6 * 0.95,3),new Wave(51,10,NormalZombie,36 * 0.95),new Wave(52,10,FemaleZombie
         ,40 * 0.925),new Wave(53,6,StrongZombie,44 * 0.95,1.5),new Wave(54,10,FlyingZombie,48 * 0.95),new Wave(55,10,NormalZombie,52 * 0.95),new Wave(56,10,HellHound,56 * 0.95),new Wave(57,8,TorsoZombie,60 * 0.95),new Wave(58,10,InvisibleZombie,66 * 0.95),new Wave(59,10,FemaleZombie,72 * 0.9),new Parade(60,6,10,3)];
      }
   }
}

