package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   
   public class Laser extends Entity
   {
      
      protected var tower:TowerEntity;
      
      protected var target:ZombieEntity;
      
      private var _sx:Number;
      
      private var _sy:Number;
      
      private var timer:Number = 0;
      
      public var start_x:Number = 0;
      
      public var start_y:Number = 0;
      
      public var end_x:Number = 0;
      
      public var end_y:Number = 0;
      
      public var color:uint = 0;
      
      private var level:int = 1;
      
      private var _sprite:Sprite;
      
      private var _g:Graphics;
      
      public function Laser(x:Number, y:Number, tower:TowerEntity, target:ZombieEntity, level:int = 1)
      {
         super();
         this.layer = 500;
         this.tower = tower;
         this.level = level;
         this.start_x = x;
         this.start_y = y;
         this._sprite = new Sprite();
         this._g = this._sprite.graphics;
         this.target = target;
         this.end_x = target.centerX;
         this.end_y = target.centerY;
         switch(level)
         {
            case 1:
               this.color = 13194563;
               break;
            case 2:
               this.color = 15910972;
               break;
            case 3:
               this.color = 9619815;
               break;
            case 4:
               this.color = 10408189;
               break;
            case 5:
               this.color = 15915007;
         }
         FP.world.add(this);
      }
      
      override public function removed() : void
      {
         this.target = null;
         this.tower = null;
         super.removed();
      }
      
      override public function render() : void
      {
         FP.buffer.draw(this._sprite);
         super.render();
      }
      
      override public function update() : void
      {
         this.end_x = this.target.centerX;
         this.end_y = this.target.centerY;
         this.timer += FP.elapsed * Globals.speed;
         if(this.timer > 0.2)
         {
            this.target.hit(this.tower.damage,this.tower);
            FP.world.remove(this);
         }
         this._g.clear();
         for(var i:int = 6; i > 0; i--)
         {
            this._g.lineStyle(i,this.color,0.1 * (7 - i));
            this._g.moveTo(this.start_x,this.start_y);
            this._g.lineTo(this.target.centerX,this.target.centerY);
         }
         super.update();
      }
   }
}

