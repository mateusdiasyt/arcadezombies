package net.flashpunk.graphics
{
   public class Anim
   {
      
      internal var _parent:Spritemap;
      
      internal var _name:String;
      
      internal var _frames:Array;
      
      internal var _frameRate:Number;
      
      internal var _frameCount:uint;
      
      internal var _loop:Boolean;
      
      public function Anim(name:String, frames:Array, frameRate:Number = 0, loop:Boolean = true)
      {
         super();
         this._name = name;
         this._frames = frames;
         this._frameRate = frameRate;
         this._loop = loop;
         this._frameCount = frames.length;
      }
      
      public function play(reset:Boolean = false) : void
      {
         this._parent.play(this._name,reset);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get frames() : Array
      {
         return this._frames;
      }
      
      public function get frameRate() : Number
      {
         return this._frameRate;
      }
      
      public function get frameCount() : uint
      {
         return this._frameCount;
      }
      
      public function get loop() : Boolean
      {
         return this._loop;
      }
   }
}

