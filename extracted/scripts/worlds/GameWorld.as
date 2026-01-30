package worlds
{
   import achievements.Tracker;
   import entities.BloodSplatter;
   import entities.Button;
   import entities.EffectEmitter;
   import entities.FlashMessage;
   import entities.HUDEntity;
   import entities.HealthBarEntity;
   import entities.MapEntity;
   import entities.RangeCircle;
   import entities.Score;
   import entities.TowerEntity;
   import entities.YouWinWindow;
   import entities.menu.OptionsMenu;
   import entities.towers.bomb.BombTower;
   import entities.towers.buzzsaw.BuzzsawTower;
   import entities.towers.fire.FireTower;
   import entities.towers.ice.IceTower;
   import entities.towers.laser.LaserTower;
   import entities.towers.rapid.RapidTower;
   import entities.towers.sam.SamTower;
   import entities.towers.sensor.SensorTower;
   import entities.towers.sentry.SentryTower;
   import flash.geom.Rectangle;
   import levels.SpawnEntity;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   import utils.ZombieList;
   
   public class GameWorld extends World
   {
      
      private var mapString:String = null;
      
      private var game_timer:Date;
      
      private var delay:Number = 0;
      
      private var reorder_timer:Number = 0;
      
      private var _end_screen_added:Boolean = false;
      
      private var _tower:TowerEntity;
      
      private var _fade_callback:Function;
      
      private var _fade_image:Image = new Image(Assets.GFX_BLACK_BOX);
      
      private var _fade_timer:Number = 0;
      
      private var _fade_out:Boolean = false;
      
      private var _fade_in:Boolean = true;
      
      private var _fade_entity:Entity;
      
      public function GameWorld()
      {
         super();
      }
      
      override public function begin() : void
      {
         this._fade_out = false;
         this._fade_in = true;
         this._fade_timer = 0;
         this._end_screen_added = false;
         Globals.loadPDL();
         Globals.updateRankFromPDL();
         this.mapString = Const.getMapNameForRank(Globals.rank);
         Globals.paused = false;
         Button.current_hover = null;
         Globals.placing_tower = null;
         Globals.end_screen = null;
         Globals.total_money = 0;
         Globals.speed = 1;
         Globals.zombies = new ZombieList();
         Globals.towers = new Array();
         add(Globals.map = new MapEntity());
         if(Globals.health_bars == null)
         {
            Globals.health_bars = new HealthBarEntity();
         }
         add(Globals.health_bars);
         if(Globals.range_circle == null)
         {
            Globals.range_circle = new RangeCircle();
         }
         add(Globals.range_circle);
         Globals.map.Load(this.mapString);
         Globals.score = new Score();
         add(Globals.spawns = new SpawnEntity());
         if(Globals.hud == null)
         {
            Globals.hud = new HUDEntity();
         }
         else
         {
            Globals.hud.reset();
         }
         add(Globals.hud);
         if(Globals.splatter == null)
         {
            Globals.splatter = new BloodSplatter();
         }
         else
         {
            Globals.splatter.reset();
         }
         add(Globals.splatter);
         if(Globals.effects == null)
         {
            Globals.effects = new EffectEmitter();
         }
         add(Globals.effects);
         this.game_timer = new Date();
         this.updateMusic();
         if(Globals.rank <= Const.BRONZE)
            SoundManager.playMusic(Assets.SFX_GAME_EASY);
         else if(Globals.rank <= Const.SILVER)
            SoundManager.playMusic(Assets.SFX_GAME_NORMAL);
         else if(Globals.rank <= Const.GOLD)
            SoundManager.playMusic(Assets.SFX_GAME_HARD);
         else
            SoundManager.playMusic(Assets.SFX_GAME_INSANE);
         add(this._fade_entity = new Entity(0,0,this._fade_image));
         super.begin();
      }
      
      public function reset() : void
      {
         Globals.zombies = null;
         Globals.towers = null;
         var time_played:Number = new Date().time - this.game_timer.time;
         Globals.tracker.incrementData(Tracker.TIME_PLAYED,time_played);
         Globals.tracker.flush();
         FlashMessage.reset();
         this.removeAll();
         this.begin();
      }
      
      override public function end() : void
      {
         var time_played:Number = new Date().time - this.game_timer.time;
         Globals.tracker.incrementData(Tracker.TIME_PLAYED,time_played);
         Globals.tracker.flush();
         SoundManager.stopMusic();
         removeAll();
         super.end();
      }
      
      override public function update() : void
      {
         var time_played:Number = NaN;
         if(Boolean(Globals.end_screen))
         {
            if(Globals.end_screen is YouWinWindow && Globals.score.score < Globals.grand_total)
            {
               if(Globals.score.money > 0)
               {
                  Globals.score.money -= 50;
                  Globals.score.score += 55;
                  if(Globals.score.money < 0)
                  {
                     Globals.score.money = 0;
                  }
               }
               else if(Globals.score.lives > 0)
               {
                  Globals.score.lives -= 1;
                  Globals.score.score += 100;
               }
               else
               {
                  Globals.score.score += 50;
               }
               if(Globals.score.score > Globals.grand_total)
               {
                  Globals.score.score = Globals.grand_total;
               }
               Globals.hud.update();
            }
            else if(FlashMessage.playing)
            {
               if(Boolean(FlashMessage.current_message))
               {
                  FlashMessage.current_message.update();
               }
            }
            else if(this._end_screen_added)
            {
               Globals.end_screen.update();
            }
            else
            {
               this._end_screen_added = true;
               FP.world.add(Globals.end_screen);
            }
         }
         else if(Globals.paused)
         {
            if(Boolean(Globals.optionsMenu))
            {
               Globals.optionsMenu.update();
               Button.resolveActions();
            }
            if(Boolean(Globals.stats))
            {
               Globals.stats.update();
               Button.resolveActions();
            }
         }
         else
         {
            super.update();
            this.reorder_timer += FP.elapsed;
            if(this.reorder_timer > 0.5)
            {
               this.reorder_timer = 0;
               Globals.zombies.reOrder();
            }
            Button.resolveActions();
            this.delay += FP.elapsed;
            if(this.delay > 60)
            {
               this.delay = 0;
               time_played = new Date().time - this.game_timer.time;
               Globals.tracker.incrementData(Tracker.TIME_PLAYED,time_played);
               Globals.tracker.flush();
               this.game_timer = new Date();
            }
            this.checkKeys();
         }
         if(this._fade_in)
         {
            this._fade_timer += FP.elapsed;
            if(this._fade_timer > 0.05)
            {
               this._fade_timer = 0;
               this._fade_image.alpha -= 0.1;
            }
            if(this._fade_image.alpha <= 0)
            {
               this._fade_in = false;
               remove(this._fade_entity);
            }
         }
         if(this._fade_out)
         {
            this._fade_timer += FP.elapsed;
            if(this._fade_timer > 0.05)
            {
               this._fade_timer = 0;
               this._fade_image.alpha += 0.1;
            }
            if(this._fade_image.alpha >= 1)
            {
               this._fade_callback();
            }
         }
         if(Globals.escape_timer <= 0 && Input.pressed(Key.ESCAPE) && !Globals.paused)
         {
            if(Boolean(Globals.tower_menu))
            {
               FP.world.remove(Globals.tower_menu);
            }
            if(Boolean(Globals.zombie_info))
            {
               FP.world.remove(Globals.zombie_info);
            }
            if(Globals.optionsMenu == null)
            {
               Globals.optionsMenu = new OptionsMenu();
            }
            Globals.selected_tower = null;
            FP.world.add(Globals.optionsMenu);
         }
      }
      
      public function fadeOut(callback:Function) : void
      {
         this._fade_callback = callback;
         this._fade_image.alpha = 0;
         add(this._fade_entity = new Entity(0,0,this._fade_image));
         this._fade_entity.layer = -1000;
         this._fade_out = true;
      }
      
      private function updateMusic() : void
      {
         var music:Number = Globals.tracker.getNumber(Tracker.MUSIC_VOLUME);
         var sfx:Number = Globals.tracker.getNumber(Tracker.SFX_VOLUME);
         if(music != Number.NEGATIVE_INFINITY)
         {
            SoundManager.setMusicVolume(music);
         }
         else
         {
            SoundManager.setMusicVolume(1);
            Globals.tracker.setData(Tracker.MUSIC_VOLUME,1);
         }
         if(sfx != Number.NEGATIVE_INFINITY)
         {
            SoundManager.setSfxVolume(sfx);
         }
         else
         {
            SoundManager.setSfxVolume(1);
            Globals.tracker.setData(Tracker.SFX_VOLUME,1);
         }
         if(Globals.tracker.getBoolean(Tracker.MUSIC_MUTED))
         {
            SoundManager.muteMusic();
         }
         if(Globals.tracker.getBoolean(Tracker.SFX_MUTED))
         {
            SoundManager.muteSfx();
         }
      }
      
      private function checkDebugKeys() : void
      {
         if(Input.pressed(Key.P))
         {
            Globals.paused = !Globals.paused;
         }
         if(Input.pressed(Key.M))
         {
            Globals.score.money += 1000;
         }
         if(Input.pressed(Key.W))
         {
            Globals.spawns.win();
         }
         if(Input.pressed(Key.Q))
         {
            Globals.lose();
         }
         if(Input.pressed(Key.A))
         {
            FlashMessage.addMessage("Test message for testing",3,new Image(Assets.GFX_ACHIEVEMENTS,new Rectangle(120,120,60,60)));
         }
         if(Input.pressed(Key.R))
         {
            FlashMessage.addMessage("Cleared Shared Object",2);
            Globals.tracker.reset();
         }
         if(Input.pressed(Key.D))
         {
            FP.console.visible = !FP.console.visible;
         }
      }
      
      private function checkKeys() : void
      {
         if(Input.pressed(Key.DIGIT_1) && Globals.score.money >= Towers["sentry"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new SentryTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_2) && Globals.score.money >= Towers["bomb"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new BombTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_3) && Globals.score.money >= Towers["sam"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new SamTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_4) && Globals.score.money >= Towers["sensor"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new SensorTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_5) && Globals.score.money >= Towers["ice"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new IceTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_6) && Globals.score.money >= Towers["rapid"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new RapidTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_7) && Globals.score.money >= Towers["buzzsaw"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new BuzzsawTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_8) && Globals.score.money >= Towers["fire"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new FireTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.DIGIT_9) && Globals.score.money >= Towers["laser"][1].cost)
         {
            Globals.hideRangeCircles();
            if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            Globals.placing_tower = new LaserTower();
            FP.world.add(Globals.placing_tower);
         }
         if(Input.pressed(Key.S))
         {
            if(Boolean(Globals.selected_tower))
            {
               Globals.selected_tower.sell();
               Globals.selected_tower = null;
            }
            else if(Boolean(Button.current_hover) && Button.current_hover is TowerEntity)
            {
               this._tower = Button.current_hover as TowerEntity;
               if(this._tower.placed)
               {
                  this._tower.sell();
                  Button.current_hover = null;
               }
            }
         }
         if(Input.pressed(Key.U))
         {
            if(Boolean(Globals.selected_tower))
            {
               Globals.selected_tower.upgrade();
            }
            else if(Boolean(Button.current_hover) && Button.current_hover is TowerEntity)
            {
               this._tower = Button.current_hover as TowerEntity;
               if(this._tower.placed)
               {
                  this._tower.upgrade();
               }
            }
         }
         if(Input.pressed(Key.SPACE))
         {
            Globals.timeline.callNextLevel();
         }
      }
   }
}

