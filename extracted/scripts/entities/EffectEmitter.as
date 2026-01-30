package entities
{
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Emitter;
   import net.flashpunk.graphics.Graphiclist;
   
   public class EffectEmitter extends Entity
   {
      
      private var emitter:Emitter;
      
      private var smokeEmitter:Emitter;
      
      private var burnEmitter:Emitter;
      
      private var splatterEmitter:Emitter;
      
      private var missileEmitter:Emitter;
      
      private var snowEmitter:Emitter;
      
      private var timer:Number = 0;
      
      private var between:Number = 0.2;
      
      private var gl:Graphiclist;
      
      public function EffectEmitter()
      {
         super();
         this.layer = Const.EFFECTS_LAYER;
         this.smokeEmitter = new Emitter(Assets.GFX_SMOKE,30,30);
         this.smokeEmitter.newType("smoke",[0,1,2,3]);
         this.smokeEmitter.setMotion("smoke",0,0,0.25,0,0,0.25);
         this.smokeEmitter.newType("bomb",[0,1,2,3]);
         this.smokeEmitter.setMotion("bomb",0,0,0.1,0,0,0.1);
         this.splatterEmitter = new Emitter(Assets.GFX_SPLATTER,30,30);
         this.splatterEmitter.newType("blood",[0,1,2,3]);
         this.splatterEmitter.setMotion("blood",0,0,0.15,0,0,0.15);
         this.snowEmitter = new Emitter(Assets.GFX_ICE_PARTICLE,1,1);
         this.snowEmitter.newType("explode",[0]);
         this.snowEmitter.setAlpha("explode",0.8,0);
         this.missileEmitter = new Emitter(Assets.GFX_BLAST_BALL,30,30);
         this.missileEmitter.newType("super",[0,1,2,3,4,5,4,3,2,1,0]);
         this.missileEmitter.setMotion("super",0,0,0.25,0,0,0.25);
         this.missileEmitter.newType("missile",[0,1,0]);
         this.missileEmitter.setMotion("missile",0,0,0.15,0,0,0.15);
         this.gl = new Graphiclist(this.smokeEmitter,this.splatterEmitter,this.snowEmitter,this.missileEmitter);
         this.graphic = this.gl;
      }
      
      public function emitSnow(x:Number, y:Number, r:Number) : void
      {
         this.snowEmitter.setMotion("explode",0,r,0.25 / Globals.speed,360,r,0.25 / Globals.speed);
         for(var i:int = 0; i < r * 5; i++)
         {
            this.snowEmitter.emit("explode",x,y);
         }
      }
      
      public function emitMissile(x:Number, y:Number, superMissile:Boolean = false) : void
      {
         if(superMissile)
         {
            this.missileEmitter.emit("super",x - 15,y - 15);
         }
         else
         {
            this.missileEmitter.emit("missile",x - 15,y - 15);
         }
      }
      
      public function emitSmoke(x:Number, y:Number, type:String = "smoke") : void
      {
         this.smokeEmitter.emit(type,x,y);
      }
      
      public function emitSplatter(x:Number, y:Number) : void
      {
         var dx:Number = Globals.randRange(x - 5,x + 5);
         var dy:Number = Globals.randRange(y - 5,y + 5);
         this.splatterEmitter.emit("blood",dx,dy);
      }
      
      override public function removed() : void
      {
      }
   }
}

