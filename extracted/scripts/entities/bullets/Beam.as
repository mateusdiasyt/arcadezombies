package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import entities.effects.Effect;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class Beam extends Entity
   {
      
      protected var parent:TowerEntity;
      
      protected var zombies:Array;
      
      protected var rank:Number;
      
      protected var damage:Number;
      
      protected var length:Number;
      
      protected var max:Number;
      
      private var timer:Number = 0;
      
      private var _sprite:Sprite = new Sprite();
      
      public function Beam(parent:TowerEntity, zombies:Array, rank:Number = 1, damage:Number = 20, length:Number = 2, max:Number = 5)
      {
         super();
         this.layer = Const.BEAM_LAYER;
         this.parent = parent;
         this.zombies = zombies;
         this.rank = rank;
         this.damage = damage;
         this.length = length;
         this.max = max;
         FP.world.add(this);
      }
      
      override public function added() : void
      {
         var z:ZombieEntity = null;
         var non_stunned:Array = this.zombies.concat();
         for(var i:int = non_stunned.length - 1; i >= 0; i--)
         {
            if(Boolean(non_stunned[i].stunned))
            {
               non_stunned.splice(i,1);
            }
         }
         if(non_stunned.length > 0)
         {
            this.zombies = non_stunned;
         }
         if(this.zombies.length > this.max)
         {
            this.zombies = this.zombies.splice(0,this.max);
         }
         this.graphic = this.getBeams();
         for each(z in this.zombies)
         {
            z.addEffect(new Effect(Effect.STUN,this.parent,1,this.damage,this.length,1,false));
         }
      }
      
      override public function removed() : void
      {
         this.parent = null;
         this.zombies = null;
         super.removed();
      }
      
      override public function update() : void
      {
         this.timer += FP.elapsed * Globals.speed;
         if(this.timer > this.length)
         {
            this.timer = 0;
            FP.world.remove(this);
         }
      }
      
      protected function getBeams() : Image
      {
         var z:ZombieEntity = null;
         var data:BitmapData = new BitmapData(FP.screen.width,FP.screen.height,true,0);
         var g:Graphics = this._sprite.graphics;
         g.clear();
         g.lineStyle(1,26367);
         g.lineStyle(2,16777215,0.5);
         g.beginFill(16777215,0.5);
         for each(z in this.zombies)
         {
            g.moveTo(this.parent.centerX,this.parent.centerY);
            g.lineTo(z.centerX,z.centerY);
            g.drawCircle(z.centerX,z.centerY,5);
         }
         g.endFill();
         data.draw(this._sprite);
         return new Image(data);
      }
   }
}

