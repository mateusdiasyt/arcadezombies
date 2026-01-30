package net.flashpunk.graphics
{
   public class Particle
   {
      
      internal var _type:ParticleType;
      
      internal var _time:Number;
      
      internal var _duration:Number;
      
      internal var _x:Number;
      
      internal var _y:Number;
      
      internal var _moveX:Number;
      
      internal var _moveY:Number;
      
      internal var _prev:Particle;
      
      internal var _next:Particle;
      
      public function Particle()
      {
         super();
      }
   }
}

