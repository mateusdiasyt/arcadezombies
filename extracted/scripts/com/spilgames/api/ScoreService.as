package com.spilgames.api
{
   public class ScoreService
   {
      
      public function ScoreService()
      {
         super();
      }
      
      public static function submitScore(score:int, callback:Function = null) : int
      {
         return SpilGamesServices.getInstance().send("Score","submitScore",callback,{
            "score":score,
            "userName":User.getUserName(),
            "userHash":User.getUserHash()
         });
      }
   }
}

