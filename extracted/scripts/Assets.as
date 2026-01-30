package
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import net.flashpunk.FP;
   
   public class Assets
   {
      
      [Embed(source="../assets/fonts/arial.ttf",embedAsCFF="false",fontName="Blah")]
      public static const FNT_ARIAL:Class = Assets_FNT_ARIAL;
      
      [Embed(source="../assets/fonts/JezzabelBimbo.ttf",embedAsCFF="false",fontFamily="JezzabelBimbo")]
      public static const FNT_JEZZABELBIMBO:Class = Assets_FNT_JEZZABELBIMBO;
      
      [Embed(source="../assets/fonts/exoteric.ttf",embedAsCFF="false",fontFamily="Exoteric")]
      public static const FNT_EXOTERIC:Class = Assets_FNT_EXOTERIC;
      
      [Embed(source="../assets/title.png")]
      public static const GFX_TITLE:Class = Assets_GFX_TITLE;
      
      [Embed(source="../assets/titlescreen.jpg")]
      public static const GFX_TITLESCREEN:Class = Assets_GFX_TITLESCREEN;
      
      [Embed(source="../assets/backgroundwindow.jpg")]
      public static const GFX_BACKGROUND_WINDOW:Class = Assets_GFX_BACKGROUND_WINDOW;
      
      [Embed(source="../assets/gameover.jpg")]
      public static const GFX_GAME_OVER:Class = Assets_GFX_GAME_OVER;
      
      [Embed(source="../assets/youwin.jpg")]
      public static const GFX_YOU_WIN:Class = Assets_GFX_YOU_WIN;
      
      [Embed(source="../assets/level_select.jpg")]
      public static const GFX_LEVEL_SELECT:Class = Assets_GFX_LEVEL_SELECT;
      
      [Embed(source="../assets/flashpunk.png")]
      public static const GFX_FLASH_PUNK:Class = Assets_GFX_FLASH_PUNK;
      
      [Embed(source="../assets/zombie_head.png")]
      public static const GFX_ZOMBIE_HEAD:Class = Assets_GFX_ZOMBIE_HEAD;
      
      [Embed(source="../assets/zombie_head_over.png")]
      public static const GFX_ZOMBIE_HEAD_OVER:Class = Assets_GFX_ZOMBIE_HEAD_OVER;
      
      [Embed(source="../assets/bullet_select.png")]
      public static const GFX_BULLET_SELECT:Class = Assets_GFX_BULLET_SELECT;
      
      [Embed(source="../assets/maps/easy.png")]
      public static const GFX_EASY_MAP:Class = Assets_GFX_EASY_MAP;
      
      [Embed(source="../assets/maps/normal.png")]
      public static const GFX_NORMAL_MAP:Class = Assets_GFX_NORMAL_MAP;
      
      [Embed(source="../assets/maps/hard.png")]
      public static const GFX_HARD_MAP:Class = Assets_GFX_HARD_MAP;
      
      [Embed(source="../assets/maps/insane.png")]
      public static const GFX_INSANE_MAP:Class = Assets_GFX_INSANE_MAP;
      
      [Embed(source="../assets/maps/EasyMap2.oel",mimeType="application/octet-stream")]
      public static const OEL_EASYMAP:Class = Assets_OEL_EASYMAP;
      
      [Embed(source="../assets/maps/NormalMap2.oel",mimeType="application/octet-stream")]
      public static const OEL_NORMALMAP:Class = Assets_OEL_NORMALMAP;
      
      [Embed(source="../assets/maps/HardMap2.oel",mimeType="application/octet-stream")]
      public static const OEL_HARDMAP:Class = Assets_OEL_HARDMAP;
      
      [Embed(source="../assets/maps/InsaneMap2.oel",mimeType="application/octet-stream")]
      public static const OEL_INSANEMAP:Class = Assets_OEL_INSANEMAP;
      
      [Embed(source="../assets/gems.png")]
      public static const GFX_GEMS:Class = Assets_GFX_GEMS;
      
      [Embed(source="../assets/HUD.png")]
      public static const GFX_HUD:Class = Assets_GFX_HUD;
      
      [Embed(source="../assets/HUD_score_text.png")]
      public static const GFX_HUD_SCORE_TEXT:Class = Assets_GFX_HUD_SCORE_TEXT;
      
      [Embed(source="../assets/banner.png")]
      public static const GFX_HUD_BANNER:Class = Assets_GFX_HUD_BANNER;
      
      [Embed(source="../assets/TowerMenu.png")]
      public static const GFX_TOWER_MENU:Class = Assets_GFX_TOWER_MENU;
      
      [Embed(source="../assets/TowerMenuHover.png")]
      public static const GFX_TOWER_MENU_HOVER:Class = Assets_GFX_TOWER_MENU_HOVER;
      
      [Embed(source="../assets/options_menu.png")]
      public static const GFX_OPTIONS_MENU:Class = Assets_GFX_OPTIONS_MENU;
      
      [Embed(source="../assets/Button.png")]
      public static const GFX_BUTTON:Class = Assets_GFX_BUTTON;
      
      [Embed(source="../assets/Button_small.png")]
      public static const GFX_BUTTON_SMALL:Class = Assets_GFX_BUTTON_SMALL;
      
      [Embed(source="../assets/info_bg.png")]
      public static const GFX_ZOMBIE_INFO:Class = Assets_GFX_ZOMBIE_INFO;
      
      [Embed(source="../assets/target.png")]
      public static const GFX_TARGET_SPRITESHEET:Class = Assets_GFX_TARGET_SPRITESHEET;
      
      [Embed(source="../assets/menu_items.png")]
      public static const GFX_MENU_ITEMS:Class = Assets_GFX_MENU_ITEMS;
      
      [Embed(source="../assets/upgrade_icons.png")]
      public static const GFX_UPGRADE_ICONS:Class = Assets_GFX_UPGRADE_ICONS;
      
      [Embed(source="../assets/helpwindow.png")]
      public static const GFX_HELP_WINDOW:Class = Assets_GFX_HELP_WINDOW;
      
      [Embed(source="../assets/dial.png")]
      public static const GFX_DIAL:Class = Assets_GFX_DIAL;
      
      [Embed(source="../assets/knob.png")]
      public static const GFX_KNOB:Class = Assets_GFX_KNOB;
      
      [Embed(source="../assets/links/tl_achiev_normal.png")]
      public static const GFX_TL_ACHIEV_NORMAL:Class = Assets_GFX_TL_ACHIEV_NORMAL;
      
      [Embed(source="../assets/links/tl_achiev_selected.png")]
      public static const GFX_TL_ACHIEV_SELECTED:Class = Assets_GFX_TL_ACHIEV_SELECTED;
      
      [Embed(source="../assets/links/tl_credits_normal.png")]
      public static const GFX_TL_CREDITS_NORMAL:Class = Assets_GFX_TL_CREDITS_NORMAL;
      
      [Embed(source="../assets/links/tl_credits_selected.png")]
      public static const GFX_TL_CREDITS_SELECTED:Class = Assets_GFX_TL_CREDITS_SELECTED;
      
      [Embed(source="../assets/links/tl_newgame_normal.png")]
      public static const GFX_TL_NEWGAME_NORMAL:Class = Assets_GFX_TL_NEWGAME_NORMAL;
      
      [Embed(source="../assets/links/tl_newgame_selected.png")]
      public static const GFX_TL_NEWGAME_SELECTED:Class = Assets_GFX_TL_NEWGAME_SELECTED;
      
      [Embed(source="../assets/links/tl_scores_normal.png")]
      public static const GFX_TL_SCORES_NORMAL:Class = Assets_GFX_TL_SCORES_NORMAL;
      
      [Embed(source="../assets/links/tl_scores_selected.png")]
      public static const GFX_TL_SCORES_SELECTED:Class = Assets_GFX_TL_SCORES_SELECTED;
      
      [Embed(source="../assets/statusicons.png")]
      public static const GFX_STATUS_ICONS:Class = Assets_GFX_STATUS_ICONS;
      
      [Embed(source="../assets/zombies.png")]
      public static const GFX_ZOMBIES:Class = Assets_GFX_ZOMBIES;
      
      [Embed(source="../assets/zombie_portraits.png")]
      public static const GFX_ZOMBIE_PORTRAITS:Class = Assets_GFX_ZOMBIE_PORTRAITS;
      
      [Embed(source="../assets/zombies_info_portraits.png")]
      public static const GFX_ZOMBIE_INFO_PORTRAITS:Class = Assets_GFX_ZOMBIE_INFO_PORTRAITS;
      
      [Embed(source="../assets/halo.png")]
      public static const GFX_HALO:Class = Assets_GFX_HALO;
      
      [Embed(source="../assets/towers.png")]
      public static const GFX_TOWER_SPRITESHEET:Class = Assets_GFX_TOWER_SPRITESHEET;
      
      [Embed(source="../assets/bases.png")]
      public static const GFX_TOWER_BASES:Class = Assets_GFX_TOWER_BASES;
      
      [Embed(source="../assets/tower_portraits.png")]
      public static const GFX_TOWER_PORTRAITS:Class = Assets_GFX_TOWER_PORTRAITS;
      
      [Embed(source="../assets/flash.png")]
      public static const GFX_SENTRY_FLASH:Class = Assets_GFX_SENTRY_FLASH;
      
      [Embed(source="../assets/missile_flash.png")]
      public static const GFX_MISSILE_FLASH:Class = Assets_GFX_MISSILE_FLASH;
      
      [Embed(source="../assets/bullet.png")]
      public static const GFX_SENTRY_BULLET:Class = Assets_GFX_SENTRY_BULLET;
      
      [Embed(source="../assets/snowball.png")]
      public static const GFX_SNOW_BALL:Class = Assets_GFX_SNOW_BALL;
      
      [Embed(source="../assets/bomb.png")]
      public static const GFX_BOMB:Class = Assets_GFX_BOMB;
      
      [Embed(source="../assets/sawblade.png")]
      public static const GFX_SAWBLADE:Class = Assets_GFX_SAWBLADE;
      
      [Embed(source="../assets/rocket.png")]
      public static const GFX_ROCKET:Class = Assets_GFX_ROCKET;
      
      [Embed(source="../assets/super_missile.png")]
      public static const GFX_SUPER_MISSILE:Class = Assets_GFX_SUPER_MISSILE;
      
      [Embed(source="../assets/flame_1.png")]
      public static const GFX_FLAME_1:Class = Assets_GFX_FLAME_1;
      
      [Embed(source="../assets/flame_2.png")]
      public static const GFX_FLAME_2:Class = Assets_GFX_FLAME_2;
      
      [Embed(source="../assets/flame_3.png")]
      public static const GFX_FLAME_3:Class = Assets_GFX_FLAME_3;
      
      [Embed(source="../assets/flame_4.png")]
      public static const GFX_FLAME_4:Class = Assets_GFX_FLAME_4;
      
      [Embed(source="../assets/flame_5.png")]
      public static const GFX_FLAME_5:Class = Assets_GFX_FLAME_5;
      
      [Embed(source="../assets/blast_ball.png")]
      public static const GFX_BLAST_BALL:Class = Assets_GFX_BLAST_BALL;
      
      [Embed(source="../assets/blast_shrapnel.png")]
      public static const GFX_BLAST_SHRAPNEL:Class = Assets_GFX_BLAST_SHRAPNEL;
      
      [Embed(source="../assets/smoke.png")]
      public static const GFX_SMOKE:Class = Assets_GFX_SMOKE;
      
      [Embed(source="../assets/snowflake.png")]
      public static const GFX_SNOW_FLAKE:Class = Assets_GFX_SNOW_FLAKE;
      
      [Embed(source="../assets/burn.png")]
      public static const GFX_BURN:Class = Assets_GFX_BURN;
      
      [Embed(source="../assets/splatter.png")]
      public static const GFX_SPLATTER:Class = Assets_GFX_SPLATTER;
      
      [Embed(source="../assets/ice_particle.png")]
      public static const GFX_ICE_PARTICLE:Class = Assets_GFX_ICE_PARTICLE;
      
      [Embed(source="../assets/blood_spec.png")]
      public static const GFX_BLOOD_SPEC:Class = Assets_GFX_BLOOD_SPEC;
      
      [Embed(source="../assets/blood_pool.png")]
      public static const GFX_BLOOD_POOL:Class = Assets_GFX_BLOOD_POOL;
      
      [Embed(source="../assets/achievements.png")]
      public static const GFX_ACHIEVEMENTS:Class = Assets_GFX_ACHIEVEMENTS;
      
      [Embed(source="../assets/achievements_disabled.png")]
      public static const GFX_ACHIEVEMENTS_DISABLED:Class = Assets_GFX_ACHIEVEMENTS_DISABLED;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Menu")]
      public static const SFX_MENU:Class = Assets_SFX_MENU;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Game_Insane")]
      public static const SFX_GAME_INSANE:Class = Assets_SFX_GAME_INSANE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Game_Hard")]
      public static const SFX_GAME_NORMAL:Class = Assets_SFX_GAME_NORMAL;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Game_Normal")]
      public static const SFX_GAME_HARD:Class = Assets_SFX_GAME_HARD;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Game_Easy")]
      public static const SFX_GAME_EASY:Class = Assets_SFX_GAME_EASY;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Cash")]
      public static const SFX_CASH:Class = Assets_SFX_CASH;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Laser")]
      public static const SFX_LASER:Class = Assets_SFX_LASER;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="SAM")]
      public static const SFX_SAM:Class = Assets_SFX_SAM;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Sensor")]
      public static const SFX_SENSOR:Class = Assets_SFX_SENSOR;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Sentry")]
      public static const SFX_SENTRY:Class = Assets_SFX_SENTRY;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Bomb")]
      public static const SFX_BOMB:Class = Assets_SFX_BOMB;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Ice")]
      public static const SFX_ICE:Class = Assets_SFX_ICE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Buzzsaw")]
      public static const SFX_BUZZSAW:Class = Assets_SFX_BUZZSAW;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Hit_1")]
      public static const SFX_HIT_1:Class = Assets_SFX_HIT_1;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Hit_2")]
      public static const SFX_HIT_2:Class = Assets_SFX_HIT_2;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Upgrade")]
      public static const SFX_UPGRADE:Class = Assets_SFX_UPGRADE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Explode")]
      public static const SFX_EXPLODE:Class = Assets_SFX_EXPLODE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Small_Explosion")]
      public static const SFX_SMALL_EXPLODE:Class = Assets_SFX_SMALL_EXPLODE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Growl_Male")]
      public static const SFX_GROWL_MALE:Class = Assets_SFX_GROWL_MALE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Growl_Female")]
      public static const SFX_GROWL_FEMALE:Class = Assets_SFX_GROWL_FEMALE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="You_Lose")]
      public static const SFX_YOU_LOSE:Class = Assets_SFX_YOU_LOSE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="You_Win")]
      public static const SFX_YOU_WIN:Class = Assets_SFX_YOU_WIN;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Life_Lost")]
      public static const SFX_LOST_LIFE:Class = Assets_SFX_LOST_LIFE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Rapid")]
      public static const SFX_MACHINE_GUN:Class = Assets_SFX_MACHINE_GUN;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Flame")]
      public static const SFX_FLAME:Class = Assets_SFX_FLAME;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="New_Wave")]
      public static const SFX_NEW_WAVE:Class = Assets_SFX_NEW_WAVE;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Difficulty_Select")]
      public static const SFX_DIFFICULTY_SELECT:Class = Assets_SFX_DIFFICULTY_SELECT;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Sell")]
      public static const SFX_SELL:Class = Assets_SFX_SELL;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Achievement")]
      public static const SFX_ACHIEVEMENT:Class = Assets_SFX_ACHIEVEMENT;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Menu_Button")]
      public static const SFX_MENU_BUTTON:Class = Assets_SFX_MENU_BUTTON;
      
      [Embed(source="../assets/sound/Sounds.swf",symbol="Score_Scroll")]
      public static const SFX_SCORE_SCROLL:Class = Assets_SFX_SCORE_SCROLL;
      
      public static var BASES:Array = new Array();
      
      public static var TURRETS:Array = new Array();
      
      BASES["sentry"] = new Rectangle(0,0,30,30);
      BASES["bomb"] = new Rectangle(0,30,30,30);
      BASES["SAM"] = new Rectangle(0,60,30,30);
      BASES["sensor"] = new Rectangle(0,90,30,30);
      BASES["ice"] = new Rectangle(0,120,30,30);
      BASES["fire"] = new Rectangle(0,150,30,30);
      BASES["buzzsaw"] = new Rectangle(0,180,30,30);
      BASES["rapid"] = new Rectangle(0,210,30,30);
      BASES["laser"] = new Rectangle(0,240,30,30);
      TURRETS["sentry"] = new Array();
      TURRETS["sentry"][1] = new Rectangle(0,0,36,36);
      TURRETS["sentry"][2] = new Rectangle(36,0,36,36);
      TURRETS["sentry"][3] = new Rectangle(72,0,36,36);
      TURRETS["sentry"][4] = new Rectangle(108,0,36,36);
      TURRETS["sentry"][5] = new Rectangle(144,0,36,36);
      TURRETS["bomb"] = new Array();
      TURRETS["bomb"][1] = new Rectangle(0,36,36,36);
      TURRETS["bomb"][2] = new Rectangle(36,36,36,36);
      TURRETS["bomb"][3] = new Rectangle(72,36,36,36);
      TURRETS["bomb"][4] = new Rectangle(108,36,36,36);
      TURRETS["bomb"][5] = new Rectangle(144,36,36,36);
      TURRETS["SAM"] = new Array();
      TURRETS["SAM"][1] = new Rectangle(0,72,36,36);
      TURRETS["SAM"][2] = new Rectangle(36,72,36,36);
      TURRETS["SAM"][3] = new Rectangle(72,72,36,36);
      TURRETS["SAM"][4] = new Rectangle(108,72,36,36);
      TURRETS["SAM"][5] = new Rectangle(144,72,36,36);
      TURRETS["sensor"] = new Array();
      TURRETS["sensor"][1] = new Rectangle(0,108,36,36);
      TURRETS["sensor"][2] = new Rectangle(36,108,36,36);
      TURRETS["sensor"][3] = new Rectangle(72,108,36,36);
      TURRETS["sensor"][4] = new Rectangle(108,108,36,36);
      TURRETS["sensor"][5] = new Rectangle(144,108,36,36);
      TURRETS["ice"] = new Array();
      TURRETS["ice"][1] = new Rectangle(0,144,36,36);
      TURRETS["ice"][2] = new Rectangle(36,144,36,36);
      TURRETS["ice"][3] = new Rectangle(72,144,36,36);
      TURRETS["ice"][4] = new Rectangle(108,144,36,36);
      TURRETS["ice"][5] = new Rectangle(144,144,36,36);
      TURRETS["fire"] = new Array();
      TURRETS["fire"][1] = new Rectangle(0,180,36,36);
      TURRETS["fire"][2] = new Rectangle(36,180,36,36);
      TURRETS["fire"][3] = new Rectangle(72,180,36,36);
      TURRETS["fire"][4] = new Rectangle(108,180,36,36);
      TURRETS["fire"][5] = new Rectangle(144,180,36,36);
      TURRETS["buzzsaw"] = new Array();
      TURRETS["buzzsaw"][1] = new Rectangle(0,216,36,36);
      TURRETS["buzzsaw"][2] = new Rectangle(36,216,36,36);
      TURRETS["buzzsaw"][3] = new Rectangle(72,216,36,36);
      TURRETS["buzzsaw"][4] = new Rectangle(108,216,36,36);
      TURRETS["buzzsaw"][5] = new Rectangle(144,216,36,36);
      TURRETS["rapid"] = new Array();
      TURRETS["rapid"][1] = new Rectangle(0,252,36,36);
      TURRETS["rapid"][2] = new Rectangle(36,252,36,36);
      TURRETS["rapid"][3] = new Rectangle(72,252,36,36);
      TURRETS["rapid"][4] = new Rectangle(108,252,36,36);
      TURRETS["rapid"][5] = new Rectangle(144,252,36,36);
      TURRETS["laser"] = new Array();
      TURRETS["laser"][1] = new Rectangle(0,288,36,36);
      TURRETS["laser"][2] = new Rectangle(36,288,36,36);
      TURRETS["laser"][3] = new Rectangle(72,288,36,36);
      TURRETS["laser"][4] = new Rectangle(108,288,36,36);
      TURRETS["laser"][5] = new Rectangle(144,288,36,36);
      TURRETS["buzzsaw_reload"] = new Array();
      TURRETS["buzzsaw_reload"][1] = new Rectangle(0,324,36,36);
      TURRETS["buzzsaw_reload"][2] = new Rectangle(36,324,36,36);
      TURRETS["buzzsaw_reload"][3] = new Rectangle(72,324,36,36);
      TURRETS["buzzsaw_reload"][4] = new Rectangle(108,324,36,36);
      TURRETS["buzzsaw_reload"][5] = new Rectangle(144,324,36,36);
      
      public function Assets()
      {
         super();
      }
      
      public static function get GFX_BLACK_BOX() : BitmapData
      {
         return new BitmapData(FP.width,FP.height,false,0);
      }
   }
}

