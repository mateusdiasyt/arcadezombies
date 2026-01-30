package entities.menu
{
   import entities.Button;
   import entities.Container;
   import entities.buttons.GenericButton;
   import entities.buttons.MuteMusicMenuButton;
   import entities.buttons.MuteSfxMenuButton;
   import entities.buttons.SoundDial;
   import flash.display.BitmapData;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   import worlds.GameWorld;
   
   public class OptionsMenu extends Container
   {
      
      private var quit:GenericButton;
      
      private var restart:GenericButton;
      
      private var returnGame:GenericButton;
      
      private var musicText:Text;
      
      private var sfxText:Text;
      
      private var _sfx_dial:SoundDial = new SoundDial();
      
      private var _music_dial:SoundDial = new SoundDial();
      
      private var _sfx_mute:MuteSfxMenuButton;
      
      private var _music_mute:MuteMusicMenuButton;
      
      public function OptionsMenu()
      {
         super(false);
         this.layer = Const.OPTION_MENU_LAYER;
         Globals.paused = true;
         Text.size = 12 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this.sfxText = new Text("SFX");
         this.sfxText.color = 0;
         this.musicText = new Text("Music");
         this.musicText.color = 0;
         this._sfx_dial.setValue(SoundManager.getRealSfxVolume());
         this._music_dial.setValue(SoundManager.getRealMusicVolume());
         var menu:Image = new Image(Assets.GFX_OPTIONS_MENU);
         menu.x = (FP.width - menu.width) / 2;
         menu.y = (FP.height - menu.height) / 2;
         this.graphic = new Graphiclist(this.getBackground(),menu);
      }
      
      private function getBackground() : Image
      {
         var data:BitmapData = new BitmapData(FP.width,FP.height,true,1711276032);
         return new Image(data);
      }
      
      override public function added() : void
      {
         Globals.paused = true;
         SoundManager.stopAllLoopingSounds();
         add(this._sfx_dial,240,170);
         add(this._music_dial,330,170);
         add(this.sfxText,262,225);
         add(this.musicText,347,225);
         add(this._sfx_mute = new MuteSfxMenuButton(),232,165);
         add(this._music_mute = new MuteMusicMenuButton(),327,165);
         add(this.quit = new GenericButton(Localizer.Instance.options_quit,0,0,function():void
         {
            (FP.world as GameWorld).fadeOut(function():void
            {
               Globals.showStartWorld();
            });
         },true),250,257);
         add(this.restart = new GenericButton(Localizer.Instance.options_restart,0,0,function():void
         {
            (FP.world as GameWorld).fadeOut(function():void
            {
               Globals.game_world.reset();
            });
         },true),321,257);
         add(this.returnGame = new GenericButton(Localizer.Instance.options_resume,0,0,function():void
         {
            Globals.tracker.flush();
            Globals.paused = false;
            FP.world.remove(Globals.optionsMenu);
         }),250,291);
         super.added();
      }
      
      override public function update() : void
      {
         if(Input.pressed(Key.ESCAPE))
         {
            Globals.escape_timer = 0.25;
            Button.clickStack.push(this.returnGame);
         }
         super.update();
         this.quit.update();
         this.restart.update();
         this.returnGame.update();
         this._sfx_mute.update();
         this._music_mute.update();
         this._sfx_dial.update();
         this._music_dial.update();
         if(SoundManager.muted_music)
         {
            this._music_dial.setValue(SoundManager.getRealMusicVolume());
            this._music_dial.disable();
         }
         else if(SoundManager.getRealMusicVolume() != this._music_dial.getValue())
         {
            this._music_dial.enable();
            SoundManager.setMusicVolume(this._music_dial.getValue());
         }
         else
         {
            this._music_dial.enable();
         }
         if(SoundManager.muted_sfx)
         {
            this._sfx_dial.setValue(SoundManager.getRealSfxVolume());
            this._sfx_dial.disable();
         }
         else if(SoundManager.getRealSfxVolume() != this._sfx_dial.getValue())
         {
            this._sfx_dial.enable();
            SoundManager.setSfxVolume(this._sfx_dial.getValue());
         }
         else
         {
            this._sfx_dial.enable();
         }
      }
   }
}

