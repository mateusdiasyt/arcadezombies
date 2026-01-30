package entities.menu
{
   import entities.Button;
   import entities.Container;
   import entities.TowerEntity;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   
   public class TowerHover extends Container
   {
      
      private var _tower:TowerEntity;
      
      private var _labels:Text;
      
      public function TowerHover(x:Number, y:Number, tower:TowerEntity)
      {
         super();
         this._tower = tower;
         this.x = x - 44;
         this.y = y - 15 - 48;
         if(this.x < 0)
         {
            this.x = 0;
         }
         if(this.y < 0)
         {
            this.y = 0;
         }
         this.graphic = this.getBackground();
      }
      
      private function getBackground() : Image
      {
         var data:BitmapData = new BitmapData(90,50,true,0);
         var s:Sprite = new Sprite();
         var g:Graphics = s.graphics;
         g.lineStyle(1,0);
         g.beginFill(13421772,0.5);
         g.drawRect(0,0,88,48);
         data.draw(s);
         return new Image(data);
      }
      
      override public function added() : void
      {
         Text.size = 12 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this._labels = new Text(Localizer.Instance.tower_hover_level + ": " + this._tower.level + "\n" + Localizer.Instance.tower_hover_kills + ": " + this._tower.kills + "\n" + Localizer.Instance.tower_hover_target + ": " + this._tower.target_state);
         this._labels.color = 0;
         add(this._labels,2,2);
      }
      
      override public function removed() : void
      {
         this._tower = null;
         super.removed();
      }
      
      override public function update() : void
      {
         if(Button.current_hover != this._tower)
         {
            FP.world.remove(this);
         }
         this._labels.text = Localizer.Instance.tower_hover_level + ": " + this._tower.level + "\n" + Localizer.Instance.tower_hover_kills + ": " + this._tower.kills + "\n" + Localizer.Instance.tower_hover_target + ": " + this._tower.target_state;
         super.update();
      }
   }
}

