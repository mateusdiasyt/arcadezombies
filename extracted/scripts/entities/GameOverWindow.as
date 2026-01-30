package entities
{
   import achievements.Tracker;
   import com.spilgames.api.ScoreService;
   import flash.display.BitmapData;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   import utils.SuperText;
   import worlds.GameWorld;
   
   public class GameOverWindow extends Container
   {
      
      private var _bg:Image = new Image(Assets.GFX_GAME_OVER);
      
      private var _black:Image;
      
      private var _score_text:SuperText;
      
      private var _score:SuperText;
      
      private var _continue:SuperText;
      
      private var _timer:Number = 0;
      
      private var showing_scores:Boolean = false;
      
      private var _alt_game_over:SuperText;
      
      public function GameOverWindow()
      {
         super(false);
         Globals.paused = true;
         this.layer = Const.WIN_LOSE_LAYER;
         var data:BitmapData = new BitmapData(FP.width,FP.height,false,0);
         this._black = new Image(data);
         add(new Entity(0,0,this._black),0,0);
         add(new Entity(0,0,this._bg),0,0);
         if(!Localizer.Instance.isDefault())
         {
            Text.size = 20 / Const.FONT_OFFSET;
            this._alt_game_over = new SuperText(Localizer.Instance.end_game_over,300,110,{
               "outlineColor":0,
               "outlineStrength":3
            });
            add(new Entity(0,0,this._alt_game_over));
         }
         Text.font = Const.FONT;
         Text.size = 48 / Const.FONT_OFFSET;
         this._score_text = new SuperText(Localizer.Instance.end_score,0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         this._score_text.color = 16777215;
         add(new Entity(0,0,this._score_text),(FP.width - this._score_text.width) / 2,180);
         this._score = new SuperText("" + Globals.score.score,0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         this._score.color = 16777215;
         add(new Entity(0,0,this._score),(FP.width - this._score.width) / 2,240);
         Text.size = 24 / Const.FONT_OFFSET;
         this._continue = new SuperText("- " + Localizer.Instance.end_click_mouse + " -",0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         this._continue.color = 16777215;
         add(new Entity(0,0,this._continue),(FP.width - this._continue.width) / 2,400);
         var pdlText:SuperText = new SuperText(Localizer.Instance.pdl_perdeu,0,0,{"outlineColor":0,"outlineStrength":5});
         pdlText.color = 16711680;
         add(new Entity(0,0,pdlText),(FP.width - pdlText.width) / 2,365);
         this._black.alpha = 0;
         this._bg.alpha = 0;
         this._score_text.alpha = 0;
         this._score.alpha = 0;
         this._continue.alpha = 0;
         if(Boolean(this._alt_game_over))
         {
            this._alt_game_over.alpha = 0;
         }
         Globals.tracker.setHighest(Tracker.HIGHEST_SCORE,Globals.score.score);
         ScoreService.submitScore(Globals.score.score);
         Globals.tracker.flush();
         Globals.addPDL(-2);
      }
      
      override public function added() : void
      {
         this.showing_scores = false;
         SoundManager.stopMusic();
         SoundManager.stopAllLoopingSounds();
         SoundManager.playSound(Assets.SFX_YOU_LOSE);
         super.added();
      }
      
      override public function removed() : void
      {
         Globals.end_screen = null;
         super.removed();
      }
      
      override public function update() : void
      {
         var b:String = null;
         this._timer += FP.elapsed;
         if(this._timer > 0.1 && this._black.alpha < 1)
         {
            this._timer = 0;
            this._black.alpha += 0.2;
         }
         if(this._timer > 0.1 && this._black.alpha >= 1 && this._bg.alpha < 1)
         {
            this._timer = 0;
            this._bg.alpha += 0.1;
            this._score_text.alpha += 0.1;
            this._score.alpha += 0.1;
            this._continue.alpha += 0.1;
            if(Boolean(this._alt_game_over))
            {
               this._alt_game_over.alpha += 0.1;
            }
         }
         if(Input.mousePressed && this._bg.alpha >= 1 && !this.showing_scores)
         {
            this.showing_scores = true;
            Globals.end_screen = null;
            b = "";
            if(Globals.rank <= Const.BRONZE) b = Globals.easyScores;
            else if(Globals.rank <= Const.SILVER) b = Globals.normalScores;
            else if(Globals.rank <= Const.GOLD) b = Globals.hardScores;
            else b = Globals.hellScores;
            (FP.world as GameWorld).fadeOut(function():void
            {
               Globals.showStartWorld();
            });
         }
         super.update();
      }
   }
}

