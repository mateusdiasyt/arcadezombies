package entities.bullets
{
   import entities.TowerEntity;
   import entities.ZombieEntity;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Emitter;
   import net.flashpunk.graphics.Graphiclist;
   
   public class SplashEntity extends Entity
   {
      
      protected var radius:Number;
      
      protected var damage:Number;
      
      protected var gl:Graphiclist = new Graphiclist();
      
      protected var circles:Array = new Array();
      
      protected var alpha_offset:Array = new Array();
      
      protected var shrapnel:Emitter = new Emitter(Assets.GFX_BLAST_SHRAPNEL,2,2);
      
      protected var blast:Emitter = new Emitter(Assets.GFX_BLAST_BALL,30,30);
      
      private var timer:Number = 0;
      
      private var duration:Number = 0.5;
      
      private var tower:TowerEntity = null;
      
      public function SplashEntity(tower:TowerEntity, x:Number, y:Number, damage:Number, radius:Number)
      {
         super();
         this.x = x;
         this.y = y;
         this.tower = tower;
         this.shrapnel.newType("explode",[0]);
         this.shrapnel.setMotion("explode",0,radius - 10,this.duration - 0.1,360,radius + 5,this.duration + 0.1);
         this.shrapnel.setAlpha("explode",0.8,0);
         for(var i:int = 0; i < 4; i++)
         {
            this.blast.newType("explode" + i,[i,i + 1,i + 2,i + 3,i + 4,i + 3,i + 2,i + 1,i]);
            this.blast.setMotion("explode" + i,0,0,this.duration - 0.1,360,0,this.duration);
         }
         this.blast.newType("explode4",[0,1,2,3,4,5,6,7,6,5,4,3,2,1]);
         this.blast.setMotion("explode4",0,0,this.duration - 0.1,360,0,this.duration);
         this.radius = radius;
         this.damage = damage;
      }
      
      override public function added() : void
      {
         this.gl.add(this.blast);
         this.gl.add(this.shrapnel);
         this.graphic = this.gl;
      }
      
      override public function removed() : void
      {
         this.tower = null;
         super.removed();
      }
      
      override public function update() : void
      {
         var r1:int = 0;
         var r2:int = 0;
         var r:int = 0;
         var zombies:Array = null;
         var z:ZombieEntity = null;
         var i:int = 0;
         if(this.timer == 0)
         {
            r1 = Globals.randRange(Math.max(5,this.radius / 2),Math.max(10,this.radius));
            r2 = Globals.randRange(Math.max(5,this.radius / 2),Math.max(10,this.radius));
            for(i = 0; i < r1; i++)
            {
               this.shrapnel.emit("explode",0,0);
            }
         }
         this.timer += FP.elapsed * Globals.speed;
         for(i = 0; i < this.circles.length; i++)
         {
            if(this.timer < this.duration / 2)
            {
               this.circles[i].alpha = this.timer / (this.duration / 2) * this.alpha_offset[i];
            }
            else
            {
               this.circles[i].alpha = 1 - (this.timer - this.duration / 2) / (this.duration / 2) * this.alpha_offset[i];
            }
         }
         var ts:int = 1;
         if(this.radius >= 40)
         {
            ts = 2;
         }
         for(i = 0; i < ts; i++)
         {
            r = Math.random() * 5;
            this.blast.setAlpha("explode" + r,Globals.randRange(0.7,1),Globals.randRange(0.1,0.5));
            this.blast.emit("explode" + r,Globals.randRange(-this.radius,this.radius) - this.radius / 2,Globals.randRange(-this.radius,this.radius) - this.radius / 2);
         }
         if(this.timer >= this.duration)
         {
            zombies = Globals.zombies.distanceTo(this.x,this.y,this.radius);
            for each(z in zombies)
            {
               z.hit(this.damage,this.tower);
            }
            FP.world.remove(this);
         }
      }
   }
}

