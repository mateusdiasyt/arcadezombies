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
   
   public class YouWinWindow extends Container
   {
      
      private var _bg:Image = new Image(Assets.GFX_YOU_WIN);
      
      private var _black:Image;
      
      private var _score_title:SuperText;
      
      private var _score:SuperText;
      
      private var _title:SuperText;
      
      private var _total:SuperText;
      
      private var _total_title:SuperText;
      
      private var _continue:SuperText;
      
      private var _alt_completed:SuperText;
      
      private var _timer:Number = 0;
      
      private var original:Number = 0;
      
      private var money:Number = 0;
      
      private var towers:Number = 0;
      
      private var lives:Number = 0;
      
      private var total:Number = 0;
      
      private var showing_scores:Boolean = false;
      
      public function YouWinWindow()
      {
         super(false);
         Globals.paused = true;
         this.original = Globals.score.score;
         this.money = Globals.score.money;
         this.towers = Globals.score.tower_score;
         this.lives = Globals.score.lives;
         this.total = Globals.score.score + Globals.score.money + Globals.score.tower_score + Globals.score.lives * 100;
         this.layer = Const.WIN_LOSE_LAYER;
         SoundManager.loopSound("YouWin1",Assets.SFX_SCORE_SCROLL);
      }
      
      override public function added() : void
      {
         this.showing_scores = false;
         SoundManager.stopMusic();
         SoundManager.stopAllLoopingSounds();
         SoundManager.playSound(Assets.SFX_YOU_WIN);
         var data:BitmapData = new BitmapData(FP.width,FP.height,false,0);
         this._black = new Image(data);
         add(new Entity(0,0,this._black),0,0);
         add(new Entity(0,0,this._bg),0,0);
         Text.font = "_sans";
         Text.size = 36 / Const.FONT_OFFSET;
         this._score_title = new SuperText(Localizer.Instance.end_vitoria,0,0,{"outlineColor":0,"outlineStrength":5});
         this._score_title.color = 16777215;
         add(new Entity(0,0,this._score_title),(FP.width - this._score_title.width) / 2,140);
         Text.size = 32 / Const.FONT_OFFSET;
         var pdlText:SuperText = new SuperText(Localizer.Instance.pdl_ganhou,0,0,{"outlineColor":0,"outlineStrength":5});
         pdlText.color = 65280;
         add(new Entity(0,0,pdlText),(FP.width - pdlText.width) / 2,200);
         var pdlAtualStr:String = Localizer.Instance.end_pdl_atual + ": " + Math.floor(Globals.pdl);
         this._total_title = new SuperText(pdlAtualStr,0,0,{"outlineColor":0,"outlineStrength":3});
         this._total_title.color = 16777215;
         add(new Entity(0,0,this._total_title),(FP.width - this._total_title.width) / 2,260);
         var eloName:String = getRankName(Globals.rank);
         var eloStr:String = Localizer.Instance.end_elo + ": " + eloName;
         this._total = new SuperText(eloStr,0,0,{"outlineColor":0,"outlineStrength":3});
         this._total.color = 16777215;
         add(new Entity(0,0,this._total),(FP.width - this._total.width) / 2,300);
         Text.size = 24 / Const.FONT_OFFSET;
         this._continue = new SuperText("- " + Localizer.Instance.end_click_mouse + " -",0,0,{"outlineColor":0,"outlineStrength":5});
         this._continue.color = 16777215;
         add(new Entity(0,0,this._continue),(FP.width - this._continue.width) / 2,380);
         this._title = null;
         this._score = null;
         this._alt_completed = null;
         this._black.alpha = 0;
         this._score_title.alpha = 0;
         this._bg.alpha = 0;
         this._total.alpha = 0;
         this._total_title.alpha = 0;
         this._continue.alpha = 0;
         if(Globals.rank <= Const.BRONZE)
         {
            Globals.tracker.incrementData(Tracker.EASY_WINS,1);
            Globals.tracker.setHighest(Tracker.HIGHEST_EASY_SCORE,Globals.score.score);
            Globals.tracker.setHighest(Tracker.HIGHEST_EASY_WIN_SCORE,Globals.score.score);
         }
         else if(Globals.rank <= Const.SILVER)
         {
            Globals.tracker.incrementData(Tracker.NORMAL_WINS,1);
            Globals.tracker.setHighest(Tracker.HIGHEST_NORMAL_SCORE,Globals.score.score);
            Globals.tracker.setHighest(Tracker.HIGHEST_NORMAL_WIN_SCORE,Globals.score.score);
         }
         else if(Globals.rank <= Const.GOLD)
         {
            Globals.tracker.incrementData(Tracker.HARD_WINS,1);
            Globals.tracker.setHighest(Tracker.HIGHEST_HARD_SCORE,Globals.score.score);
            Globals.tracker.setHighest(Tracker.HIGHEST_HARD_WIN_SCORE,Globals.score.score);
         }
         else
         {
            Globals.tracker.incrementData(Tracker.INSANE_WINS,1);
            Globals.tracker.setHighest(Tracker.HIGHEST_INSANE_SCORE,Globals.score.score);
            Globals.tracker.setHighest(Tracker.HIGHEST_INSANE_WIN_SCORE,Globals.score.score);
         }
         Globals.tracker.setHighest(Tracker.HIGHEST_SCORE,Globals.score.score);
         Globals.tracker.flush();
         ScoreService.submitScore(Globals.score.score);
         Globals.addPDL(3);
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
            this._score_title.alpha += 0.1;
            this._bg.alpha += 0.1;
            this._total.alpha += 0.1;
            this._total_title.alpha += 0.1;
            this._title.alpha += 0.1;
            this._score.alpha += 0.1;
            this._continue.alpha += 0.1;
            if(Boolean(this._alt_completed))
            {
               this._alt_completed.alpha += 0.1;
            }
         }
         if(this._timer > 0.1 && this._black.alpha >= 1 && this._bg.alpha < 1)
         {
            this._timer = 0;
            this._score_title.alpha += 0.1;
            this._bg.alpha += 0.1;
            this._total.alpha += 0.1;
            this._total_title.alpha += 0.1;
            this._continue.alpha += 0.1;
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
      
      private function getRankName(rank:Number) : String
      {
         if(rank <= Const.BRONZE) return Localizer.Instance.rank_bronze;
         if(rank <= Const.SILVER) return Localizer.Instance.rank_silver;
         if(rank <= Const.GOLD) return Localizer.Instance.rank_gold;
         if(rank <= Const.PLATINUM) return Localizer.Instance.rank_platinum;
         if(rank <= Const.DIAMOND) return Localizer.Instance.rank_diamond;
         return Localizer.Instance.rank_master;
      }
   }
}

