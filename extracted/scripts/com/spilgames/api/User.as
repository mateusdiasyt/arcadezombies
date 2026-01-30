package com.spilgames.api
{
   import flash.display.DisplayObject;
   
   public class User
   {
      
      public function User()
      {
         super();
      }
      
      public static function isGuest() : Boolean
      {
         var root:DisplayObject = null;
         var vars:Object = null;
         var connection:* = SpilGamesServices.getInstance().connection;
         if(connection != null)
         {
            return connection.isGuest();
         }
         root = SpilGamesServices.getInstance().root;
         if(root.loaderInfo != null)
         {
            vars = root.loaderInfo.parameters;
            return !vars.username || vars.username == "" || !vars.hash || vars.hash == "";
         }
         return false;
      }
      
      public static function getUserName() : String
      {
         var connection:* = SpilGamesServices.getInstance().connection;
         if(connection != null)
         {
            return connection.getUserName();
         }
         return "";
      }
      
      public static function getUserHash() : String
      {
         var connection:* = SpilGamesServices.getInstance().connection;
         if(connection != null)
         {
            return connection.getUserHash();
         }
         return "";
      }
   }
}

