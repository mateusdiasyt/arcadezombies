package entities.buttons
{
   import entities.Button;
   import entities.Tooltip;
   import entities.menu.HelpMenu;
   import net.flashpunk.FP;
   
   public class StatsButton extends Button
   {
      
      private var _tooltip:Tooltip;
      
      public function StatsButton()
      {
         super();
         this.setHitbox(25,25);
      }
      
      override public function mouseOver() : void
      {
         this._tooltip = new Tooltip(this.x,this.y + 20,Localizer.Instance.toolbar_view_help,this);
      }
      
      override public function mouseOut() : void
      {
         FP.world.remove(this._tooltip);
         this._tooltip = null;
      }
      
      override public function clickAction() : void
      {
         if(Globals.stats == null)
         {
            Globals.stats = new HelpMenu();
         }
         FP.world.add(Globals.stats);
         FP.world.remove(this._tooltip);
         this._tooltip = null;
      }
   }
}

