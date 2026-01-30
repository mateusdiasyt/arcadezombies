package entities
{
   import flash.geom.Point;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Spritemap;
   
   public class FlameThrower2 extends Entity
   {
      
      public static var LVL1_W:Number = 32;
      
      public static var LVL1_H:Number = 17;
      
      public static var LVL2_W:Number = 39;
      
      public static var LVL2_H:Number = 20;
      
      public static var LVL3_W:Number = 46;
      
      public static var LVL3_H:Number = 24;
      
      public static var LVL4_W:Number = 53;
      
      public static var LVL4_H:Number = 28;
      
      public static var LVL5_W:Number = 60;
      
      public static var LVL5_H:Number = 32;
      
      public var image:Spritemap = null;
      
      private var flame_width:Number = LVL1_W;
      
      private var flame_height:Number = LVL1_H;
      
      private var tower:TowerEntity = null;
      
      public function FlameThrower2(tower:TowerEntity, level:int = 1)
      {
         super();
         this.layer = Const.FLAME_THROWER_LAYER;
         this.tower = tower;
         switch(level)
         {
            case 1:
               this.image = new Spritemap(Assets.GFX_FLAME_1,60,30);
               this.flame_width = LVL1_W;
               this.flame_height = LVL1_H;
               break;
            case 2:
               this.image = new Spritemap(Assets.GFX_FLAME_2,60,30);
               this.flame_width = LVL1_W;
               this.flame_height = LVL1_H;
               break;
            case 3:
               this.image = new Spritemap(Assets.GFX_FLAME_3,60,30);
               this.flame_width = LVL2_W;
               this.flame_height = LVL2_H;
               break;
            case 4:
               this.image = new Spritemap(Assets.GFX_FLAME_4,60,30);
               this.flame_width = LVL3_W;
               this.flame_height = LVL3_H;
               break;
            case 5:
               this.image = new Spritemap(Assets.GFX_FLAME_5,60,30);
               this.flame_width = LVL4_W;
               this.flame_height = LVL4_H;
               break;
            default:
               this.image = new Spritemap(Assets.GFX_FLAME_1,60,30);
               this.flame_width = LVL5_W;
               this.flame_height = LVL5_H;
         }
      }
      
      override public function added() : void
      {
         this.image.alpha = 0;
         this.image.add("fire",[0,1,2],10);
         this.image.play("fire");
         this.image.x = -60;
         this.image.y = 0;
         this.image.originX = 75;
         this.image.originY = 15;
         this.graphic = this.image;
      }
      
      override public function removed() : void
      {
         this.tower = null;
         super.removed();
      }
      
      public function getHit() : Array
      {
         var j:int = 0;
         var z:ZombieEntity = null;
         var d:Number = NaN;
         var dist:Number = NaN;
         var hit:Array = new Array();
         var zombies:Array = Globals.zombies.getGround(this.tower.centerX,this.tower.centerY,this.tower.range);
         var dh:Number = this.flame_width;
         var p:Point = new Point();
         for(var i:int = 1; i < 5; i++)
         {
            dh -= this.flame_height / Math.pow(2,i);
            p.x = this.tower.centerX - Math.cos(-this.tower.turret.angle * Math.PI / 180) * (15 + dh);
            p.y = this.tower.centerY - Math.sin(-this.tower.turret.angle * Math.PI / 180) * (15 + dh);
            for(j = zombies.length - 1; j >= 0; j--)
            {
               z = zombies[j];
               d = this.flame_height / Math.pow(2,i);
               dist = this.getdistance(z.centerX,z.centerY,p.x,p.y);
               if(dist < d + 16)
               {
                  hit.push(z);
                  zombies.splice(j,1);
               }
            }
         }
         return hit;
      }
      
      public function show() : void
      {
         this.image.alpha = 1;
      }
      
      public function hide() : void
      {
         this.image.alpha = 0;
      }
      
      private function getdistance(x1:Number, y1:Number, x2:Number, y2:Number) : Number
      {
         var dx:Number = x1 - x2;
         var dy:Number = y1 - y2;
         return Math.sqrt(dx * dx + dy * dy);
      }
   }
}

