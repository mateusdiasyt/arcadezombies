package entities
{
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Emitter;
   import net.flashpunk.graphics.Graphiclist;
   
   public class BloodSplatter extends Entity
   {
      
      private var poolEmitter:Emitter;
      
      private var specEmitter:Emitter;
      
      private var gl:Graphiclist = new Graphiclist();
      
      public function BloodSplatter()
      {
         super();
         this.layer = Const.BLOOD_SPLATTER_LAYER;
         this.setup();
      }
      
      public function setup() : void
      {
         this.specEmitter = new Emitter(Assets.GFX_BLOOD_SPEC,3,3);
         this.specEmitter.newType("specs",[0]);
         this.specEmitter.setMotion("specs",0,0,2);
         this.specEmitter.setAlpha("specs",1,0);
         this.poolEmitter = new Emitter(Assets.GFX_BLOOD_POOL,10,10);
         this.poolEmitter.newType("pool",[0]);
         this.poolEmitter.setMotion("pool",0,0,2);
         this.poolEmitter.setAlpha("pool",1,0);
         this.gl.add(this.poolEmitter);
         this.gl.add(this.specEmitter);
         this.graphic = this.gl;
      }
      
      public function reset() : void
      {
         this.graphic = null;
         this.gl = new Graphiclist();
         this.setup();
      }
      
      public function splat(x:Number, y:Number) : void
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         var i:int = 0;
         var specs:int = int(Math.random() * 20) + 1;
         var pools:int = int(Math.random() * 5) + 1;
         for(i = 0; i < specs; i++)
         {
            dx = x + Math.random() * 20 - 10;
            dy = y + Math.random() * 20 - 10;
            this.specEmitter.emit("specs",dx,dy);
         }
         for(i = 0; i < pools; i++)
         {
            dx = x + Math.random() * 10 - 5;
            dy = y + Math.random() * 10 - 5;
            this.poolEmitter.emit("pool",dx,dy);
         }
      }
   }
}

