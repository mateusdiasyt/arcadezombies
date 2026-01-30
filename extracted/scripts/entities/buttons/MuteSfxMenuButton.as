package entities.buttons
{
   import entities.Button;
   import entities.Tooltip;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class MuteSfxMenuButton extends Button
   {
      
      public var image:Spritemap = new Spritemap(Assets.GFX_MENU_ITEMS,24,24);
      
      private var tooltip:Tooltip;
      
      public function MuteSfxMenuButton()
      {
         super();
         this.image.add("unmuted",[5]);
         this.image.add("muted",[4]);
         this.image.play("unmuted");
         this.setHitbox(30,30);
         this.graphic = this.image;
      }
      
      override public function update() : void
      {
         if(SoundManager.muted_sfx)
         {
            this.image.play("muted");
         }
         else
         {
            this.image.play("unmuted");
         }
         super.update();
      }
      
      override public function mouseOver() : void
      {
         if(SoundManager.muted_sfx)
         {
            this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_unmute_sfx,this);
         }
         else
         {
            this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_mute_sfx,this);
         }
      }
      
      override public function mouseOut() : void
      {
         FP.world.remove(this.tooltip);
         this.tooltip = null;
      }
      
      override public function clickAction() : void
      {
         if(!SoundManager.muted_sfx)
         {
            SoundManager.muteSfx();
            this.image.play("muted");
         }
         else
         {
            SoundManager.unmuteSfx();
            this.image.play("unmuted");
         }
         if(Boolean(this.tooltip))
         {
            FP.world.remove(this.tooltip);
            this.tooltip = null;
         }
      }
   }
}

