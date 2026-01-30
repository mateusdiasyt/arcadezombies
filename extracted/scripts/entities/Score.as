package entities
{
   public class Score
   {
      
      public var money:Number = 50;
      
      public var lives:Number = 20;
      
      public var score:Number = 0;
      
      public var level:Number = 1;
      
      public var max_level:Number = 50;
      
      public var tower_score:Number = 0;
      
      public function Score()
      {
         super();
         if(Globals.rank <= Const.BRONZE)
            this.money = 70;
         else if(Globals.rank <= Const.SILVER)
            this.money = 60;
         else if(Globals.rank <= Const.GOLD)
            this.money = 55;
         else if(Globals.rank <= Const.PLATINUM)
            this.money = 50;
         else if(Globals.rank <= Const.DIAMOND)
            this.money = 45;
         else
            this.money = 40;
      }
      
      public function increaseMoney(i:int, called_early:Number = 1) : void
      {
         this.score += i * called_early;
         this.money += i;
      }
   }
}

