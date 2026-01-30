package worlds
{
   import entities.Button;
   import entities.buttons.ImageButton;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   
   public class CreditsWorld extends World
   {
      
      private var _fade_callback:Function;
      
      private var _fade_image:Image = new Image(Assets.GFX_BLACK_BOX);
      
      private var _fade_timer:Number = 0;
      
      private var _fade_out:Boolean = false;
      
      private var _fade_in:Boolean = true;
      
      public function CreditsWorld()
      {
         super();
         Button.current_hover = null;
         add(new Entity(0,0,new Stamp(Assets.GFX_BACKGROUND_WINDOW)));
         Text.font = Const.FONT;
         Text.size = 24 / Const.FONT_OFFSET;
         var zhg:ImageButton = new ImageButton(0,0,224,100,Assets.GFX_ZOMBIE_HEAD,Assets.GFX_ZOMBIE_HEAD,null);
         zhg.y = 10;
         zhg.x = (640 - 224) / 2 + 4;
         var art:Text = new Text(Localizer.Instance.credits_graphics);
         art.color = 0;
         var music:Text = new Text(Localizer.Instance.credits_music);
         music.color = 0;
         var programming:Text = new Text(Localizer.Instance.credits_code);
         programming.color = 0;
         var testers:Text = new Text(Localizer.Instance.credits_beta);
         testers.color = 0;
         var names:Text = new Text("Anders Johansson, Nate Weldon, Alessandro Passoni, and Kasey O\'Neill");
         names.color = 0;
         Text.size = 36 / Const.FONT_OFFSET;
         var richard:Text = new Text("Richard Fhager");
         richard.color = 0;
         var matt:Text = new Text("Matt Borchert");
         matt.color = 0;
         var dan:Text = new Text("Dan Curran");
         dan.color = 0;
         var flash_punk:Image = new Image(Assets.GFX_FLASH_PUNK);
         add(zhg);
         add(new Entity((FP.width - art.width) / 2,110,art));
         add(new Entity((FP.width - richard.width) / 2,135,richard));
         add(new Entity((FP.width - music.width) / 2,190,music));
         add(new Entity((FP.width - matt.width) / 2,215,matt));
         add(new Entity((FP.width - programming.width) / 2,270,programming));
         add(new Entity((FP.width - dan.width) / 2,295,dan));
         add(new Entity((FP.width - testers.width) / 2,350,testers));
         add(new Entity((FP.width - names.width) / 2,380,names));
         add(new Entity((FP.width - flash_punk.width) / 2,420,flash_punk));
         add(new Entity(0,0,this._fade_image));
      }
      
      override public function begin() : void
      {
         this._fade_out = false;
         this._fade_in = true;
         this._fade_timer = 0;
         super.begin();
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
         if(Input.mousePressed || Input.pressed(Key.ESCAPE))
         {
            this.fadeOut(function():void
            {
               Globals.showStartWorld();
            });
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

