package spill.localisation
{
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class SpilGamesLink extends SimpleButton
   {
      
      public function SpilGamesLink()
      {
         super();
         addEventListener(MouseEvent.CLICK,buttonClicked);
      }
      
      private function buttonClicked(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(SpilGame.getSpilCompanyLink()),"_blank");
      }
   }
}

