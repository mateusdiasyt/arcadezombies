package entities.buttons
{
   import entities.Button;
   import entities.TowerEntity;
   import net.flashpunk.graphics.Spritemap;
   
   public class TargetStrongButton extends Button
   {
      
      public var target:TowerEntity = null;
      
      private var sm:Spritemap = null;
      
      private var _disabled:Boolean = false;
      
      public function TargetStrongButton(t:TowerEntity, on:Boolean = false, disabled:Boolean = false)
      {
         super();
         this.target = t;
         this._disabled = disabled;
         this.sm = new Spritemap(Assets.GFX_TARGET_SPRITESHEET,33,21);
         this.graphic = this.sm;
         this.sm.add("off",[2]);
         this.sm.add("on",[6]);
         this.sm.add("disabled",[10]);
         if(on)
         {
            this.sm.play("on");
         }
         else
         {
            this.sm.play("off");
         }
         if(this._disabled)
         {
            this.sm.play("disabled");
         }
         this.setHitbox(33,21);
      }
      
      override public function removed() : void
      {
         this.target = null;
         this.sm = null;
         this.graphic = null;
         super.removed();
      }
      
      override public function clickAction() : void
      {
         if(!this._disabled)
         {
            this.target.setTargetState(TowerEntity.TARGET_STRONGEST);
            this.sm.play("on");
         }
      }
   }
}

