package worlds
{
   import entities.Button;
   import entities.buttons.GenericButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.graphics.Text;
   import spill.localisation.BrandingLogo;
   import spill.localisation.LanguageSelectBox;
   import spill.localisation.LocalizedTextField;
   import spill.localisation.SpilGame;
   import spill.localisation.SpilGamesLink;
   import utils.SuperText;
   
   public class StartWorld extends World
   {
      
      private var _title:Image;
      
      private var _iniciar:GenericButton = null;
      
      private var _ranking:GenericButton = null;
      
      private var _credits:GenericButton = null;
      
      private var _flicker_timer:Number = 0;
      
      private var _flicker_delay:Number = 1;
      
      private var _flicker_on_timer:Number = 0;
      
      private var _flicker_on_delay:Number = 0;
      
      private var startComplete:Boolean = false;
      
      private var _fade_timer:Number = 0;
      
      private var _title_x:Number = 6;
      
      private var _title_y:Number = 105;
      
      private var _move_by:Number = 15;
      
      private var _ease:Number = 5;
      
      private var _version:Text;
      
      private var _fade_callback:Function;
      
      private var _fade_image:Image;
      
      private var _fade_inout_timer:Number = 0;
      
      private var _fade_out:Boolean = false;
      
      private var _fade_in:Boolean = true;
      
      private var languageSelectionBox:LanguageSelectBox;
      
      private var brandingLogo:BrandingLogo;
      
      private var spilButton:SpilGamesLink;
      
      private var moreGames:LocalizedTextField;
      
      private var _showing_ranking:Boolean = false;
      
      private var _ranking_entities:Array = [];
      
      public function StartWorld()
      {
         this._title = new Image(Assets.GFX_TITLE);
         this._fade_image = new Image(Assets.GFX_BLACK_BOX);
         super();
         Button.current_hover = null;
         this._title.x = this._title_x;
         this._title.y = this._title_y;
         this._title.alpha = 0;
         Text.font = Const.FONT_TEXT;
         Text.size = 12 / Const.FONT_OFFSET;
         this._version = new Text("v 0.2.6 [SPIL]");
         Globals.loadPDL();
         this._iniciar = new GenericButton(Localizer.Instance.start_iniciar_partida,-380,390,function():void
         {
            fadeOut(function():void
            {
               Globals.showGameWorld();
            });
         }, false, true);
         this._ranking = new GenericButton(Localizer.Instance.start_ranking,-380,430,function():void
         {
            fadeOut(function():void
            {
               showRankingOverlay();
            });
         }, false, true);
         this._credits = new GenericButton(Localizer.Instance.start_credits,-380,470,function():void
         {
            fadeOut(function():void
            {
               Globals.showCreditsWorld();
            });
         }, false, true);
      }
      
      override public function begin() : void
      {
         var alt_title:SuperText = null;
         this.languageSelectionBox = new LanguageSelectBox();
         this.languageSelectionBox.x = 450;
         this.languageSelectionBox.y = 438;
         this.moreGames = new LocalizedTextField();
         this.moreGames.textColor = 16777215;
         this.moreGames.font = Const.FONT;
         this.moreGames.embedFonts = false;
         this.moreGames.hAlign = "center";
         this.moreGames.textSize = 14;
         this.moreGames.setSize(200,40);
         this.moreGames.text = "{branding_more_games_sentence_long}";
         this.moreGames.x = 422;
         this.moreGames.y = 375;
         this.brandingLogo = new BrandingLogo();
         this.brandingLogo.x = 523;
         this.brandingLogo.y = 410;
         this.brandingLogo.mouseEnabled = this.brandingLogo.buttonMode = this.brandingLogo.useHandCursor = true;
         this.brandingLogo.addEventListener(MouseEvent.CLICK,function():void
         {
            navigateToURL(new URLRequest(SpilGame.getMoreGamesLink("Mainscreen")),"_blank");
         });
         this.spilButton = new SpilGamesLink();
         this.spilButton.x = 468;
         this.spilButton.y = 420;
         this.spilButton.addEventListener(MouseEvent.CLICK,function():void
         {
            navigateToURL(new URLRequest(SpilGame.getSpilCompanyLink()));
         });
         this._fade_out = false;
         this._fade_in = true;
         this._fade_inout_timer = 0;
         this._title.alpha = 0;
         this._fade_timer = 0;
         this._flicker_on_timer = 0;
         this._flicker_on_delay = 0;
         Button.current_hover = null;
         this.startComplete = false;
         this._fade_timer = 0;
         add(new Entity(0,0,new Stamp(Assets.GFX_TITLESCREEN)));
         add(new Entity(0,0,this._title));
         this._iniciar.x = -380;
         this._ranking.x = -380;
         this._credits.x = -380;
         add(this._iniciar);
         add(this._ranking);
         add(this._credits);
         add(new Entity(560,460,this._version));
         add(new Entity(0,0,this._fade_image));
         if(!Localizer.Instance.isDefault())
         {
            Text.size = 20 / Const.FONT_OFFSET;
            alt_title = new SuperText(Localizer.Instance.start_game_title,0,0,{
               "outlineColor":0,
               "outlineStrength":3
            });
            alt_title.color = 16777215;
            add(new Entity(120,270,alt_title));
         }
         if(SoundManager.currentSource != Assets.SFX_MENU)
         {
            SoundManager.playMusic(Assets.SFX_MENU,true);
         }
         FP.screen.color = 0;
         Main.container.addChild(this.brandingLogo);
         Main.container.addChild(this.spilButton);
         Main.container.addChild(this.languageSelectionBox);
         Main.container.addChild(this.moreGames);
      }
      
      override public function end() : void
      {
         this.removeAll();
         Main.container.removeChild(this.languageSelectionBox);
         Main.container.removeChild(this.brandingLogo);
         Main.container.removeChild(this.spilButton);
         Main.container.removeChild(this.moreGames);
      }
      
      private function flickerLoop() : void
      {
         this._flicker_timer += FP.elapsed;
         if(this._flicker_timer > this._flicker_delay)
         {
            if(this._title.alpha == 1)
            {
               this._title.alpha = Math.random() * 0.4 + 0.2;
               this._flicker_on_delay = 0.1;
            }
            else
            {
               this._flicker_on_timer += FP.elapsed;
               if(this._flicker_on_timer > this._flicker_on_delay)
               {
                  this._flicker_on_timer = 0;
                  this._title.alpha = 1;
                  this._title.x = this._title_x;
                  this._title.y = this._title_y;
                  this._flicker_delay = Math.random() * 3 + 6;
                  this._flicker_timer = 0;
               }
               else
               {
                  if(Math.random() < 0.5)
                  {
                     this._title.x = this._title_x + 2;
                  }
                  else
                  {
                     this._title.x = this._title_x - 2;
                  }
                  if(Math.random() < 0.5)
                  {
                     this._title.y = this._title_y + 2;
                  }
                  else
                  {
                     this._title.y = this._title_y - 2;
                  }
               }
            }
         }
      }
      
      private function getRankName(rank:Number) : String
      {
         if(rank <= Const.BRONZE) return Localizer.Instance.rank_bronze;
         if(rank <= Const.SILVER) return Localizer.Instance.rank_silver;
         if(rank <= Const.GOLD) return Localizer.Instance.rank_gold;
         if(rank <= Const.PLATINUM) return Localizer.Instance.rank_platinum;
         if(rank <= Const.DIAMOND) return Localizer.Instance.rank_diamond;
         return Localizer.Instance.rank_master;
      }
      
      private function showRankingOverlay() : void
      {
         Globals.loadPDL();
         this._showing_ranking = true;
         this._fade_out = false;
         this._fade_in = true;
         this._fade_image.alpha = 1;
         add(new Entity(0,0,this._fade_image));
         var bgE:Entity = new Entity(0,0,new Stamp(Assets.GFX_BACKGROUND_WINDOW));
         add(bgE);
         this._ranking_entities.push(bgE);
         Text.font = Const.FONT;
         Text.size = 28 / Const.FONT_OFFSET;
         var title:Text = new Text(Localizer.Instance.ranking_title);
         title.color = 0;
         var titleE:Entity = new Entity((FP.width - title.width) / 2,40,title);
         add(titleE);
         this._ranking_entities.push(titleE);
         Text.size = 20 / Const.FONT_OFFSET;
         var pdlLine:Text = new Text(Localizer.Instance.ranking_pdl + ": " + Math.floor(Globals.pdl));
         pdlLine.color = 0;
         var pdlE:Entity = new Entity((FP.width - pdlLine.width) / 2,120,pdlLine);
         add(pdlE);
         this._ranking_entities.push(pdlE);
         var eloName:String = getRankName(Globals.rank);
         var eloLine:Text = new Text(Localizer.Instance.ranking_elo + ": " + eloName);
         eloLine.color = 0;
         var eloE:Entity = new Entity((FP.width - eloLine.width) / 2,160,eloLine);
         add(eloE);
         this._ranking_entities.push(eloE);
         var voltar:GenericButton = new GenericButton(Localizer.Instance.ranking_voltar,0,0,function():void
         {
            var i:int = 0;
            for each(var e:Entity in _ranking_entities)
            {
               remove(e);
            }
            _ranking_entities = [];
            _showing_ranking = false;
         });
         voltar.x = (FP.width - 120) / 2;
         voltar.y = 250;
         add(voltar);
         this._ranking_entities.push(voltar);
      }
      
      public function suppressAll() : void
      {
         this._iniciar.suppressed = true;
         this._ranking.suppressed = true;
         this._credits.suppressed = true;
      }
      
      private function startLoop() : void
      {
         this._fade_timer += FP.elapsed;
         if(this._fade_timer > 0.05)
         {
            this._fade_timer = 0;
            this._title.alpha += 0.02;
            if(this._iniciar.x <= 19)
            {
               this._iniciar.x -= (this._iniciar.x - 20) / this._ease;
            }
            else
            {
               this._iniciar.x = 20;
               this._iniciar.suppressed = false;
            }
            if(this._iniciar.x > -100 && this._ranking.x <= 19)
            {
               this._ranking.x -= (this._ranking.x - 20) / this._ease;
            }
            else if(this._ranking.x > 19)
            {
               this._ranking.x = 20;
               this._ranking.suppressed = false;
            }
            if(this._ranking.x > -100 && this._credits.x <= 19)
            {
               this._credits.x -= (this._credits.x - 20) / this._ease;
            }
            else if(this._credits.x > 19)
            {
               this._credits.x = 20;
               this._credits.suppressed = false;
            }
         }
         if(this._title.alpha >= 1 && this._credits.x >= 18)
         {
            this.startComplete = true;
         }
      }
      
      override public function update() : void
      {
         if(!this.startComplete)
         {
            this.startLoop();
         }
         else
         {
            this.flickerLoop();
         }
         if(this._fade_in)
         {
            this._fade_inout_timer += FP.elapsed;
            if(this._fade_inout_timer > 0.05)
            {
               this._fade_inout_timer = 0;
               this._fade_image.alpha -= 0.1;
            }
            if(this._fade_image.alpha <= 0)
            {
               this._fade_in = false;
            }
         }
         if(this._fade_out)
         {
            this._fade_inout_timer += FP.elapsed;
            if(this._fade_inout_timer > 0.05)
            {
               this._fade_inout_timer = 0;
               this._fade_image.alpha += 0.1;
            }
            if(this._fade_image.alpha >= 1)
            {
               this._fade_callback();
            }
         }
         super.update();
         Button.resolveActions();
      }
      
      public function fadeOut(callback:Function) : void
      {
         this._fade_callback = callback;
         this._fade_image.alpha = 0;
         add(new Entity(0,0,this._fade_image));
         this._fade_out = true;
      }
   }
}

