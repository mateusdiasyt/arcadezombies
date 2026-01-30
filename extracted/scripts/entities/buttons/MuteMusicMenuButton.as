package entities.buttons
{
   import entities.Button;
   import entities.Tooltip;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class MuteMusicMenuButton extends Button
   {
      
      public var image:Spritemap = new Spritemap(Assets.GFX_MENU_ITEMS,24,24);
      
      private var tooltip:Tooltip;
      
      public function MuteMusicMenuButton()
      {
         super();
         this.image.add("unmuted",[3]);
         this.image.add("muted",[2]);
         this.image.play("unmuted");
         this.setHitbox(30,30);
         this.graphic = this.image;
      }
      
      override public function update() : void
      {
         if(SoundManager.muted_music)
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
         if(SoundManager.muted_music)
         {
            this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_unmute_music,this);
         }
         else
         {
            this.tooltip = new Tooltip(this.x + 18,this.y + 18,Localizer.Instance.toolbar_mute_music,this);
         }
      }
      
      override public function mouseOut() : void
      {
         if(Boolean(this.tooltip))
         {
            FP.world.remove(this.tooltip);
            this.tooltip = null;
         }
      }
      
      override public function clickAction() : void
      {
         if(!SoundManager.muted_music)
         {
            SoundManager.muteMusic();
            this.image.play("muted");
         }
         else
         {
            SoundManager.unmuteMusic();
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

