package worlds
{
   import entities.Button;
   import entities.buttons.DifficultyButton;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   import utils.SuperText;
   
   public class DifficultyWorld extends World
   {
      
      private var _easy:DifficultyButton;
      
      private var _normal:DifficultyButton;
      
      private var _hard:DifficultyButton;
      
      private var _insane:DifficultyButton;
      
      private var _timer:Number = 0;
      
      private var _fade_callback:Function;
      
      private var _fade_image:Image = new Image(Assets.GFX_BLACK_BOX);
      
      private var _fade_timer:Number = 0;
      
      private var _fade_out:Boolean = false;
      
      private var _fade_in:Boolean = true;
      
      public function DifficultyWorld()
      {
         super();
         Button.current_hover = null;
      }
      
      override public function begin() : void
      {
         var alt_select:SuperText = null;
         var alt_easy:SuperText = null;
         var alt_normal:SuperText = null;
         var alt_hard:SuperText = null;
         var alt_hell:SuperText = null;
         add(new Entity(0,0,new Stamp(Assets.GFX_LEVEL_SELECT)));
         this._timer = 0;
         this._fade_out = false;
         this._fade_in = true;
         this._fade_timer = 0;
         Button.current_hover = null;
         this._easy = new DifficultyButton(115,10,function():void
         {
            fadeOut(function():void
            {
               Globals.difficulty = Const.EASY;
               Globals.showGameWorld();
            });
         });
         this._easy.x = 0;
         this._easy.y = 0;
         this._normal = new DifficultyButton(20,10,function():void
         {
            fadeOut(function():void
            {
               Globals.difficulty = Const.NORMAL;
               Globals.showGameWorld();
            });
         });
         this._normal.x = 360;
         this._normal.y = 0;
         this._hard = new DifficultyButton(115,120,function():void
         {
            fadeOut(function():void
            {
               Globals.difficulty = Const.HARD;
               Globals.showGameWorld();
            });
         });
         this._hard.x = 0;
         this._hard.y = 265;
         this._insane = new DifficultyButton(50,120,function():void
         {
            fadeOut(function():void
            {
               Globals.difficulty = Const.INSANE;
               Globals.showGameWorld();
            });
         });
         this._insane.x = 360;
         this._insane.y = 265;
         add(this._easy);
         add(this._normal);
         add(this._hard);
         add(this._insane);
         if(!Localizer.Instance.isDefault())
         {
            Text.size = 20 / Const.FONT_OFFSET;
            alt_select = new SuperText(Localizer.Instance.difficulty_select,0,0,{
               "outlineColor":0,
               "outlineStrength":3
            });
            alt_select.color = 16777215;
            alt_easy = new SuperText(Localizer.Instance.difficulty_easy,0,0,{
               "outlineColor":0,
               "outlineStrength":3
            });
            alt_easy.color = 16777215;
            alt_normal = new SuperText(Localizer.Instance.difficulty_normal,0,0,{
               "outlineColor":0,
               "outlineStrength":3
            });
            alt_normal.color = 16777215;
            alt_hard = new SuperText(Localizer.Instance.difficulty_hard,0,0,{
               "outlineColor":0,
               "outlineStrength":3
            });
            alt_hard.color = 16777215;
            alt_hell = new SuperText(Localizer.Instance.difficulty_hell,0,0,{
               "outlineColor":0,
               "outlineStrength":3
            });
            alt_hell.color = 16777215;
            add(new Entity((640 - alt_select.width) / 2,260,alt_select));
            add(new Entity(70,65,alt_easy));
            add(new Entity(485,65,alt_normal));
            add(new Entity(70,450,alt_hard));
            add(new Entity(520,450,alt_hell));
         }
         add(new Entity(0,0,this._fade_image));
      }
      
      override public function end() : void
      {
         this.removeAll();
         super.end();
      }
      
      public function suppressAll() : void
      {
         this._easy.suppressed = true;
         this._normal.suppressed = true;
         this._hard.suppressed = true;
         this._insane.suppressed = true;
      }
      
      override public function update() : void
      {
         super.update();
         if(this._timer <= 0.25)
         {
            this._timer += FP.elapsed;
            if(this._timer > 0.25)
            {
               this._easy.suppressed = false;
               this._normal.suppressed = false;
               this._hard.suppressed = false;
               this._insane.suppressed = false;
            }
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
         if(Input.pressed(Key.ESCAPE))
         {
            Button.current_hover = null;
            this.fadeOut(function():void
            {
               Globals.showStartWorld();
            });
         }
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

