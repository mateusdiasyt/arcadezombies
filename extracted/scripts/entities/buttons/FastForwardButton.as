package entities.buttons
{
   import entities.Button;
   import entities.Tooltip;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class FastForwardButton extends Button
   {
      
      public var on:Boolean = false;
      
      public var image:Spritemap = new Spritemap(Assets.GFX_MENU_ITEMS,24,24);
      
      private var tooltip:Tooltip;
      
      public function FastForwardButton()
      {
         super();
         this.image.add("on",[1]);
         this.image.add("off",[0]);
         this.image.play("off");
         this.setHitbox(30,30);
         this.graphic = this.image;
      }
      
      override public function mouseOver() : void
      {
         if(this.on)
         {
            this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_decrease_speed,this);
         }
         else
         {
            this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_increase_speed,this);
         }
      }
      
      override public function mouseOut() : void
      {
         FP.world.remove(this.tooltip);
         this.tooltip = null;
      }
      
      override public function clickAction() : void
      {
         if(this.on)
         {
            this.on = false;
            Globals.speed = 1;
            this.image.play("off");
         }
         else
         {
            this.on = true;
            Globals.speed = 2;
            this.image.play("on");
         }
         if(Boolean(this.tooltip))
         {
            FP.world.remove(this.tooltip);
            this.tooltip = null;
         }
      }
   }
}

