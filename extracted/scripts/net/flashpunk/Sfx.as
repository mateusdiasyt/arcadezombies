package net.flashpunk
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class Sfx
   {
      
      private static var _sounds:Dictionary = new Dictionary();
      
      public var complete:Function;
      
      private var _vol:Number = 1;
      
      private var _pan:Number = 0;
      
      private var _sound:Sound;
      
      private var _channel:SoundChannel;
      
      private var _transform:SoundTransform = new SoundTransform();
      
      private var _position:Number = 0;
      
      private var _looping:Boolean;
      
      public function Sfx(source:Class, complete:Function = null)
      {
         super();
         this._sound = _sounds[source];
         if(!this._sound)
         {
            this._sound = _sounds[source] = new source();
         }
         this.complete = complete;
      }
      
      public function play(vol:Number = 1, pan:Number = 0) : void
      {
         if(Boolean(this._channel))
         {
            this.stop();
         }
         this._vol = this._transform.volume = vol < 0 ? 0 : vol;
         this._pan = this._transform.pan = pan < -1 ? -1 : (pan > 1 ? 1 : pan);
         this._channel = this._sound.play(0,0,this._transform);
         if(Boolean(this._channel))
         {
            this._channel.addEventListener(Event.SOUND_COMPLETE,this.onComplete);
         }
         this._looping = false;
         this._position = 0;
      }
      
      public function loop(vol:Number = 1, pan:Number = 0) : void
      {
         this.play(vol,pan);
         this._looping = true;
      }
      
      public function stop() : Boolean
      {
         if(!this._channel)
         {
            return false;
         }
         this._position = this._channel.position;
         this._channel.removeEventListener(Event.SOUND_COMPLETE,this.onComplete);
         this._channel.stop();
         this._channel = null;
         return true;
      }
      
      public function resume() : void
      {
         this._channel = this._sound.play(this._position,0,this._transform);
         this._channel.addEventListener(Event.SOUND_COMPLETE,this.onComplete);
         this._position = 0;
      }
      
      private function onComplete(e:Event = null) : void
      {
         if(this._looping)
         {
            this.loop(this._vol,this._pan);
         }
         else
         {
            this.stop();
         }
         this._position = 0;
         if(this.complete != null)
         {
            this.complete();
         }
      }
      
      public function get volume() : Number
      {
         return this._vol;
      }
      
      public function set volume(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         if(!this._channel || this._vol == value)
         {
            return;
         }
         this._vol = this._transform.volume = value;
         this._channel.soundTransform = this._transform;
      }
      
      public function get pan() : Number
      {
         return this._pan;
      }
      
      public function set pan(value:Number) : void
      {
         if(value < -1)
         {
            value = -1;
         }
         if(value > 1)
         {
            value = 1;
         }
         if(!this._channel || this._pan == value)
         {
            return;
         }
         this._pan = this._transform.pan = value;
         this._channel.soundTransform = this._transform;
      }
      
      public function get playing() : Boolean
      {
         return this._channel != null;
      }
      
      public function get position() : Number
      {
         return (Boolean(this._channel) ? this._channel.position : this._position) / 1000;
      }
      
      public function get length() : Number
      {
         return this._sound.length / 1000;
      }
   }
}

