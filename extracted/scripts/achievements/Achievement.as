package achievements
{
   import com.spilgames.api.AwardsService;
   import entities.FlashMessage;
   import flash.geom.Rectangle;
   import net.flashpunk.graphics.Image;
   
   public class Achievement
   {
      
      public var achieved:Boolean = false;
      
      public var message:String = "";
      
      public var award_type:String = "";
      
      public var image_rect:Rectangle;
      
      public function Achievement(message:String, achieved:Boolean = false)
      {
         super();
         this.message = message;
         this.achieved = achieved;
      }
      
      public function checkCondition() : Boolean
      {
         return false;
      }
      
      public function check(showMessage:Boolean = true) : void
      {
         if(!this.achieved)
         {
            if(this.checkCondition())
            {
               this.achieved = true;
               if(showMessage)
               {
                  FlashMessage.addMessage(this.message,2,new Image(Assets.GFX_ACHIEVEMENTS,this.image_rect));
                  switch(this.award_type)
                  {
                     case "award1":
                     case "award2":
                     case "award3":
                     case "award4":
                     case "award5":
                        trace("Sending Achievement to Spil");
                        AwardsService.submitAward(this.award_type);
                  }
               }
            }
         }
      }
      
      public function getEntity() : AchievementEntity
      {
         return new AchievementEntity(this);
      }
   }
}

