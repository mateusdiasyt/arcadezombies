package com.spilgames.api
{
   public class AwardsService
   {
      
      public function AwardsService()
      {
         super();
      }
      
      public static function submitAward(awardTag:String, callback:Function = null) : int
      {
         return SpilGamesServices.getInstance().send("Awards","submitAward",callback,{
            "tag":awardTag,
            "userName":User.getUserName(),
            "userHash":User.getUserHash()
         });
      }
   }
}

