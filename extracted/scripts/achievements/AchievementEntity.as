package achievements
{
   import entities.Button;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import utils.SuperText;
   
   public class AchievementEntity extends Button
   {
      
      private var a:Achievement;
      
      private var _enabled:Image;
      
      private var _disabled:Image;
      
      public function AchievementEntity(a:Achievement)
      {
         super();
         this.a = a;
         this._enabled = new Image(Assets.GFX_ACHIEVEMENTS,a.image_rect);
         this._disabled = new Image(Assets.GFX_ACHIEVEMENTS_DISABLED,a.image_rect);
         if(a.achieved)
         {
            this._enabled.alpha = 1;
            this._disabled.alpha = 0;
         }
         else
         {
            this._enabled.alpha = 0;
            this._disabled.alpha = 1;
         }
         this.setHitbox(60,60);
         this.graphic = new Graphiclist(this._enabled,this._disabled);
      }
      
      override public function mouseOver() : void
      {
         this._enabled.alpha = 1;
         this._disabled.alpha = 0;
         Text.font = Const.FONT;
         Text.size = 24 / Const.FONT_OFFSET;
         var m:String = this.a.message;
         if(this.a.achieved)
         {
            m += " Awarded";
         }
         else
         {
            m += " Not Yet Awarded";
         }
         var at:SuperText = new SuperText(m,0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         at.color = 16775392;
         at.x = -this.x + (FP.width - at.width) / 2;
         at.y = -this.y + 45;
         this.graphic = new Graphiclist(this._enabled,this._disabled,at);
      }
      
      override public function mouseOut() : void
      {
         if(this.a.achieved)
         {
            this._enabled.alpha = 1;
            this._disabled.alpha = 0;
         }
         else
         {
            this._enabled.alpha = 0;
            this._disabled.alpha = 1;
         }
         this.graphic = new Graphiclist(this._enabled,this._disabled);
      }
   }
}

