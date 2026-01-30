package entities
{
   import achievements.EasyGoldAchievement;
   import achievements.HardGoldAchievement;
   import achievements.InsaneGoldAchievement;
   import achievements.NormalGoldAchievement;
   import entities.buttons.FastForwardButton;
   import entities.buttons.MenuItem;
   import entities.buttons.MuteMusicMenuButton;
   import entities.buttons.MuteSfxMenuButton;
   import entities.buttons.NextLevelDial;
   import entities.buttons.OptionsMenuButton;
   import entities.buttons.StatsButton;
   import flash.geom.Rectangle;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import spill.localisation.SpilGame;
   import utils.SuperText;
   
   public class HUDEntity extends Container
   {
      
      private var image:Image = new Image(Assets.GFX_HUD);
      
      private var moneyText:Text;
      
      private var scoreText:Text;
      
      private var livesText:Text;
      
      private var levelText:Text;
      
      private var sentryMenu:MenuItem;
      
      private var bombMenu:MenuItem;
      
      private var samMenu:MenuItem;
      
      private var sensorMenu:MenuItem;
      
      private var iceMenu:MenuItem;
      
      private var fireMenu:MenuItem;
      
      private var buzzMenu:MenuItem;
      
      private var rapidMenu:MenuItem;
      
      private var laserMenu:MenuItem;
      
      private var _alt_money:SuperText;
      
      private var _alt_lives:SuperText;
      
      private var _alt_level:SuperText;
      
      private var _alt_score:SuperText;
      
      private var _score_text:Image;
      
      private var _banner:Image;
      
      private var betweenLevel:Text;
      
      public function HUDEntity()
      {
         super(false);
         this.x = 480;
         this.y = 0;
         this.graphic = this.image;
         this.layer = Const.HUD_LAYER;
         this.sentryMenu = new MenuItem("sentry");
         this.bombMenu = new MenuItem("bomb");
         this.samMenu = new MenuItem("sam");
         this.sensorMenu = new MenuItem("sensor");
         this.iceMenu = new MenuItem("ice");
         this.fireMenu = new MenuItem("fire");
         this.buzzMenu = new MenuItem("buzzsaw");
         this.rapidMenu = new MenuItem("rapid");
         this.laserMenu = new MenuItem("laser");
         switch(SpilGame.currentLanguage.name)
         {
            case "pt":
            case "br":
            case "de":
            case "fr":
            case "ru":
            case "es":
            case "es_ar":
            case "es_mx":
            case "id":
            case "it":
            case "nl":
            case "pl":
            case "se":
               Text.size = 18 / Const.FONT_OFFSET;
               break;
            default:
               Text.size = 22 / Const.FONT_OFFSET;
         }
         Text.font = Const.FONT;
         this.moneyText = new Text("000000");
         this.moneyText.color = 0;
         this.livesText = new Text("000000");
         this.livesText.color = 0;
         this.levelText = new Text("000000");
         this.levelText.color = 0;
         this.scoreText = new Text("000000");
         this.scoreText.color = 0;
         Text.size = 12 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this.betweenLevel = new Text("30");
         this.betweenLevel.color = 0;
         this._score_text = new Image(Assets.GFX_HUD_SCORE_TEXT);
         this._banner = new Image(Assets.GFX_HUD_BANNER);
         switch(SpilGame.currentLanguage.name)
         {
            case "pt":
            case "br":
            case "de":
            case "fr":
            case "ru":
            case "es":
            case "es_ar":
            case "es_mx":
            case "id":
            case "it":
            case "nl":
            case "pl":
            case "se":
               Text.size = 18 / Const.FONT_OFFSET;
               break;
            default:
               Text.size = 24 / Const.FONT_OFFSET;
         }
         Text.font = Const.FONT;
         this._alt_money = new SuperText(Localizer.Instance.hud_money,0,0,{
            "outlineColor":0,
            "outlineStrength":3
         });
         this._alt_money.color = 15400938;
         this._alt_lives = new SuperText(Localizer.Instance.hud_lives,0,0,{
            "outlineColor":0,
            "outlineStrength":3
         });
         this._alt_lives.color = 15400938;
         this._alt_level = new SuperText(Localizer.Instance.hud_level,0,0,{
            "outlineColor":0,
            "outlineStrength":3
         });
         this._alt_level.color = 15400938;
         this._alt_score = new SuperText(Localizer.Instance.hud_score,0,0,{
            "outlineColor":0,
            "outlineStrength":3
         });
         this._alt_score.color = 15400938;
      }
      
      override public function added() : void
      {
         add(this.sentryMenu,9,170);
         add(this.bombMenu,60,170);
         add(this.samMenu,111,170);
         add(this.sensorMenu,9,219);
         add(this.iceMenu,60,219);
         add(this.fireMenu,60,268);
         add(this.buzzMenu,9,268);
         add(this.rapidMenu,111,219);
         add(this.laserMenu,111,268);
         if(Localizer.Instance.isDefault())
         {
            add(new Entity(0,0,this._score_text),20,74);
         }
         else
         {
            add(new Entity(0,0,this._alt_money),19,65);
            add(new Entity(0,0,this._alt_lives),19,87);
            add(new Entity(0,0,this._alt_level),19,109);
            add(new Entity(0,0,this._alt_score),19,131);
         }
         var x_loc:Number = 80;
         switch(SpilGame.currentLanguage.name)
         {
            case "pt":
            case "br":
            case "de":
            case "fr":
            case "ru":
            case "es":
            case "es_ar":
            case "es_mx":
            case "id":
            case "it":
            case "nl":
            case "pl":
            case "se":
               x_loc = 95;
               break;
            default:
               x_loc = 80;
         }
         add(new Entity(0,0,this.moneyText),x_loc,68);
         add(new Entity(0,0,this.livesText),x_loc,90);
         add(new Entity(0,0,this.levelText),x_loc,112);
         add(new Entity(0,0,this.scoreText),x_loc,134);
         add(new NextLevelDial(494,328),0,0);
         add(new StatsButton(),135,312);
         add(new FastForwardButton(),26,377);
         add(new OptionsMenuButton(),52,377);
         add(new MuteSfxMenuButton(),83,377);
         add(new MuteMusicMenuButton(),110,377);
         add(new Entity(0,0,this._banner),5,413);
         if(Globals.timeline == null)
         {
            Globals.timeline = new TimeLine();
         }
         add(Globals.timeline,15,333);
         if(Globals.tracker.hasAchievement(EasyGoldAchievement))
         {
            add(new Image(Assets.GFX_GEMS,new Rectangle(0,0,13,13)),48,208);
         }
         if(Globals.tracker.hasAchievement(NormalGoldAchievement))
         {
            add(new Image(Assets.GFX_GEMS,new Rectangle(13,0,13,13)),99,208);
         }
         if(Globals.tracker.hasAchievement(HardGoldAchievement))
         {
            add(new Image(Assets.GFX_GEMS,new Rectangle(26,0,13,13)),48,257);
         }
         if(Globals.tracker.hasAchievement(InsaneGoldAchievement))
         {
            add(new Image(Assets.GFX_GEMS,new Rectangle(39,0,13,13)),99,257);
         }
      }
      
      public function reset() : void
      {
         if(Boolean(Globals.timeline))
         {
            Globals.timeline.reset();
         }
         this.sentryMenu.mouseOut();
         this.bombMenu.mouseOut();
         this.samMenu.mouseOut();
         this.sensorMenu.mouseOut();
         this.iceMenu.mouseOut();
         this.rapidMenu.mouseOut();
         this.buzzMenu.mouseOut();
         this.fireMenu.mouseOut();
         this.laserMenu.mouseOut();
      }
      
      override public function update() : void
      {
         this.moneyText.text = "" + Globals.score.money;
         this.livesText.text = "" + Globals.score.lives;
         this.scoreText.text = "" + Globals.score.score;
         this.levelText.text = Globals.score.level + "/" + Globals.score.max_level;
         this.betweenLevel.text = Globals.spawns.timeRemaining;
         super.update();
      }
      
      public function hideTowerInfo() : void
      {
         this.sentryMenu.removeMenu();
         this.bombMenu.removeMenu();
         this.samMenu.removeMenu();
         this.sensorMenu.removeMenu();
         this.iceMenu.removeMenu();
         this.rapidMenu.removeMenu();
         this.buzzMenu.removeMenu();
         this.fireMenu.removeMenu();
         this.laserMenu.removeMenu();
      }
   }
}

