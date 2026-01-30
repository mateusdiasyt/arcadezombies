package entities.buttons
{
   import entities.Button;
   import entities.Tooltip;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import net.flashpunk.FP;
   
   public class NextLevelDial extends Button
   {
      
      private var _sprite:Sprite;
      
      private var _g:Graphics;
      
      private var _cx:Number = 0;
      
      private var _cy:Number = 0;
      
      private var _tooltip:Tooltip;
      
      public function NextLevelDial(cx:Number, cy:Number)
      {
         super();
         this._cx = cx;
         this._cy = cy;
         this._sprite = new Sprite();
         this._g = this._sprite.graphics;
         this.setHitbox(25,25,0,-310);
      }
      
      override public function mouseOver() : void
      {
         this._tooltip = new Tooltip(this._cx + 8,this._cy,Localizer.Instance.toolbar_next_level,this);
      }
      
      override public function mouseOut() : void
      {
         FP.world.remove(this._tooltip);
         this._tooltip = null;
      }
      
      override public function clickAction() : void
      {
         Globals.timeline.callNextLevel();
         if(Boolean(this._tooltip))
         {
            FP.world.remove(this._tooltip);
         }
         this._tooltip = null;
      }
      
      override public function render() : void
      {
         FP.buffer.draw(this._sprite);
         super.render();
      }
      
      override public function update() : void
      {
         this._g.clear();
         var per:Number = 110 * Globals.spawns.percentRemaining - 110 / 2 - 90;
         var rad:Number = per * Math.PI / 180;
         var dx:Number = this._cx + Math.cos(rad) * 11;
         var dy:Number = this._cy + Math.sin(rad) * 11;
         this._g.lineStyle(1,6710886,1);
         this._g.moveTo(this._cx,this._cy);
         this._g.lineTo(dx,dy);
         super.update();
      }
   }
}

