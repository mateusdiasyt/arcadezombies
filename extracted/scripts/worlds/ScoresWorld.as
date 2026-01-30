package worlds
{
   import entities.Button;
   import entities.buttons.GenericButton;
   import mochi.as3.MochiScores;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   import utils.SuperText;
   
   public class ScoresWorld extends World
   {
      
      private var _fade_callback:Function;
      
      private var _fade_image:Image;
      
      private var _fade_timer:Number = 0;
      
      private var _fade_out:Boolean = false;
      
      private var _fade_in:Boolean = true;
      
      private var easyButton:GenericButton;
      
      private var normalButton:GenericButton;
      
      private var hardButton:GenericButton;
      
      private var hellButton:GenericButton;
      
      private var showing_scores:Boolean = false;
      
      public function ScoresWorld()
      {
         var t:SuperText;
         this._fade_image = new Image(Assets.GFX_BLACK_BOX);
         super();
         add(new Entity(0,0,new Stamp(Assets.GFX_BACKGROUND_WINDOW)));
         add(new Entity(0,0,this._fade_image));
         Text.size = 36 / Const.FONT_OFFSET;
         Text.font = Const.FONT;
         t = new SuperText("Scores",0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         t.color = 16775392;
         add(new Entity(20,10,t));
         this.easyButton = new GenericButton("Easy High Scores",0,125,function():void
         {
            showEasyScores();
         });
         this.easyButton.x = (FP.width - this.easyButton.width) / 2;
         this.normalButton = new GenericButton("Normal High Scores",0,175,function():void
         {
            showNormalScores();
         });
         this.normalButton.x = (FP.width - this.easyButton.width) / 2;
         this.hardButton = new GenericButton("Hard High Scores",0,225,function():void
         {
            showHardScores();
         });
         this.hardButton.x = (FP.width - this.easyButton.width) / 2;
         this.hellButton = new GenericButton("Hell High Scores",0,275,function():void
         {
            showHellScores();
         });
         this.hellButton.x = (FP.width - this.easyButton.width) / 2;
         add(this.easyButton);
         add(this.normalButton);
         add(this.hardButton);
         add(this.hellButton);
      }
      
      override public function begin() : void
      {
         Button.current_hover = null;
         this._fade_out = false;
         this._fade_in = true;
         this._fade_timer = 0;
         super.begin();
      }
      
      private function showEasyScores() : void
      {
         this.showing_scores = true;
         MochiScores.showLeaderboard({
            "boardID":Globals.easyScores,
            "onDisplay":function():void
            {
            },
            "onClose":function():void
            {
               showing_scores = false;
            }
         });
      }
      
      private function showNormalScores() : void
      {
         this.showing_scores = true;
         MochiScores.showLeaderboard({
            "boardID":Globals.normalScores,
            "onDisplay":function():void
            {
            },
            "onClose":function():void
            {
               showing_scores = false;
            }
         });
      }
      
      private function showHardScores() : void
      {
         this.showing_scores = true;
         MochiScores.showLeaderboard({
            "boardID":Globals.hardScores,
            "onDisplay":function():void
            {
            },
            "onClose":function():void
            {
               showing_scores = false;
            }
         });
      }
      
      private function showHellScores() : void
      {
         this.showing_scores = true;
         MochiScores.showLeaderboard({
            "boardID":Globals.hellScores,
            "onDisplay":function():void
            {
            },
            "onClose":function():void
            {
               showing_scores = false;
            }
         });
      }
      
      override public function update() : void
      {
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
         super.update();
         Button.resolveActions();
         if((Input.mousePressed || Input.pressed(Key.ESCAPE)) && !this.showing_scores)
         {
            this.fadeOut(function():void
            {
               Globals.showStartWorld();
            });
         }
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

