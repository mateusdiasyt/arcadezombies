package entities.buttons
{
   import entities.Button;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   import worlds.DifficultyWorld;
   
   public class DifficultyButton extends Button
   {
      
      private var _function:Function;
      
      private var _select:Image = new Image(Assets.GFX_BULLET_SELECT);
      
      public var suppressed:Boolean = true;
      
      public function DifficultyButton(x:Number, y:Number, f:Function)
      {
         super();
         this.setHitbox(280,215);
         this._select.x = x;
         this._select.y = y;
         this._select.alpha = 0;
         this._function = f;
         this.graphic = this._select;
      }
      
      override public function clickAction() : void
      {
         (FP.world as DifficultyWorld).suppressAll();
         this._function();
         this._select.alpha = 0;
      }
      
      override public function mouseOver() : void
      {
         this._select.alpha = 1;
         if(!this.suppressed)
         {
            SoundManager.playSound(Assets.SFX_DIFFICULTY_SELECT,1,true);
         }
      }
      
      override public function mouseOut() : void
      {
         this._select.alpha = 0;
      }
   }
}

