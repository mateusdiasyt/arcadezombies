package
{
   import achievements.Tracker;
   import net.flashpunk.Sfx;
   
   public class SoundManager
   {
      
      public static var currentSource:Class;
      
      private static var _currentMusic:Sfx;
      
      public static var muted_sfx:Boolean = false;
      
      public static var muted_music:Boolean = false;
      
      public static var musicVolume:Number = 1;
      
      public static var sfxVolume:Number = 1;
      
      private static var _pre_mute_musicVolume:Number = 0;
      
      private static var _pre_mute_sfxVolume:Number = 0;
      
      private static var _loopingSounds:Array = new Array();
      
      public function SoundManager()
      {
         super();
      }
      
      public static function get currentMusic() : Sfx
      {
         return _currentMusic;
      }
      
      public static function playMusic(source:Class, menu:Boolean = false) : void
      {
         if(Boolean(_currentMusic))
         {
            _currentMusic.stop();
         }
         currentSource = source;
         _currentMusic = new Sfx(source);
         if(!menu)
         {
            _currentMusic.volume = musicVolume;
            _currentMusic.loop(musicVolume);
         }
         else
         {
            _currentMusic.volume = 1;
            _currentMusic.loop(1);
         }
      }
      
      public static function stopMusic() : void
      {
         if(Boolean(_currentMusic))
         {
            _currentMusic.stop();
            _currentMusic = null;
         }
      }
      
      public static function playSound(source:Class, volumeOffset:Number = 1, menu:Boolean = false) : void
      {
         var s:Sfx = new Sfx(source,null);
         if(!menu)
         {
            s.play(sfxVolume * volumeOffset,0);
         }
         else
         {
            s.play(1,0);
         }
      }
      
      public static function loopSound(id:String, source:Class, pan:Number = 0, callback:Function = null) : void
      {
         _loopingSounds[id] = new Sfx(source,callback);
         _loopingSounds[id].loop(sfxVolume,pan);
      }
      
      public static function stopLoopingSound(id:String) : void
      {
         if(Boolean(_loopingSounds[id]))
         {
            _loopingSounds[id].stop();
            _loopingSounds[id] = null;
         }
      }
      
      public static function stopAllLoopingSounds() : void
      {
         var id:String = null;
         for(id in _loopingSounds)
         {
            stopLoopingSound(id);
         }
      }
      
      public static function setLoopingSoundsVolume(volume:Number) : void
      {
         var id:String = null;
         for(id in _loopingSounds)
         {
            if(Boolean(_loopingSounds[id]))
            {
               _loopingSounds[id].volume = volume;
            }
         }
      }
      
      public static function isPlaying(id:String) : Boolean
      {
         if(Boolean(_loopingSounds[id]))
         {
            return true;
         }
         return false;
      }
      
      public static function setMusicVolume(vol:Number) : void
      {
         if(Boolean(_currentMusic))
         {
            _currentMusic.volume = vol;
         }
         musicVolume = vol;
         if(muted_music)
         {
            Globals.tracker.setData(Tracker.MUSIC_VOLUME,_pre_mute_musicVolume);
         }
         else
         {
            Globals.tracker.setData(Tracker.MUSIC_VOLUME,vol);
         }
      }
      
      public static function setSfxVolume(vol:Number) : void
      {
         setLoopingSoundsVolume(vol);
         sfxVolume = vol;
         if(muted_sfx)
         {
            Globals.tracker.setData(Tracker.SFX_VOLUME,_pre_mute_sfxVolume);
         }
         else
         {
            Globals.tracker.setData(Tracker.SFX_VOLUME,vol);
         }
      }
      
      public static function muteSfx() : void
      {
         muted_sfx = true;
         _pre_mute_sfxVolume = sfxVolume;
         sfxVolume = 0;
         setLoopingSoundsVolume(sfxVolume);
         Globals.tracker.setData(Tracker.SFX_MUTED,true);
      }
      
      public static function unmuteSfx() : void
      {
         muted_sfx = false;
         sfxVolume = _pre_mute_sfxVolume;
         setLoopingSoundsVolume(sfxVolume);
         Globals.tracker.setData(Tracker.SFX_MUTED,false);
      }
      
      public static function muteMusic() : void
      {
         muted_music = true;
         _pre_mute_musicVolume = musicVolume;
         musicVolume = 0;
         if(Boolean(_currentMusic))
         {
            _currentMusic.volume = musicVolume;
         }
         Globals.tracker.setData(Tracker.MUSIC_MUTED,true);
      }
      
      public static function unmuteMusic() : void
      {
         muted_music = false;
         musicVolume = _pre_mute_musicVolume;
         if(Boolean(_currentMusic))
         {
            _currentMusic.volume = musicVolume;
         }
         Globals.tracker.setData(Tracker.MUSIC_MUTED,false);
      }
      
      public static function getRealMusicVolume() : Number
      {
         if(muted_music)
         {
            return _pre_mute_musicVolume;
         }
         return musicVolume;
      }
      
      public static function getRealSfxVolume() : Number
      {
         if(muted_music)
         {
            return _pre_mute_sfxVolume;
         }
         return sfxVolume;
      }
   }
}

