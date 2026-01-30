package entities.buttons
{
   import entities.Button;
   import entities.Tooltip;
   import entities.menu.OptionsMenu;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class OptionsMenuButton extends Button
   {
      
      public var image:Spritemap = new Spritemap(Assets.GFX_MENU_ITEMS,24,24);
      
      private var tooltip:Tooltip;
      
      public function OptionsMenuButton()
      {
         super();
         this.image.add("option",[7]);
         this.image.play("option");
         this.setHitbox(30,30);
         this.graphic = this.image;
      }
      
      override public function mouseOver() : void
      {
         this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_options_menu,this);
      }
      
      override public function mouseOut() : void
      {
         FP.world.remove(this.tooltip);
         this.tooltip = null;
      }
      
      override public function clickAction() : void
      {
         if(Globals.optionsMenu == null)
         {
            Globals.optionsMenu = new OptionsMenu();
         }
         FP.world.add(Globals.optionsMenu);
         if(Boolean(this.tooltip))
         {
            FP.world.remove(this.tooltip);
            this.tooltip = null;
         }
      }
   }
}

