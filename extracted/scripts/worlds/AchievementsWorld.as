package worlds
{
   import achievements.Achievement;
   import achievements.AchievementEntity;
   import entities.Button;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   import utils.SuperText;
   
   public class AchievementsWorld extends World
   {
      
      private var _fade_callback:Function;
      
      private var _fade_image:Image = new Image(Assets.GFX_BLACK_BOX);
      
      private var _fade_timer:Number = 0;
      
      private var _fade_out:Boolean = false;
      
      private var _fade_in:Boolean = true;
      
      public function AchievementsWorld()
      {
         super();
      }
      
      override public function begin() : void
      {
         var ae:AchievementEntity = null;
         Button.current_hover = null;
         add(new Entity(0,0,new Stamp(Assets.GFX_BACKGROUND_WINDOW)));
         Text.size = 36 / Const.FONT_OFFSET;
         Text.font = Const.FONT;
         var t:SuperText = new SuperText("Medals",0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         t.color = 16775392;
         add(new Entity(20,10,t));
         this._fade_out = false;
         this._fade_in = true;
         this._fade_timer = 0;
         var ach:Array = Globals.tracker.getAchievements();
         var a:Array = [];
         var row:Number = 0;
         for(var i:int = 0; i < ach.length; i++)
         {
            ae = (ach[i] as Achievement).getEntity();
            add(ae);
            a[i] = ae;
         }
         a[0].x = 60;
         a[0].y = 135;
         a[1].x = 115;
         a[1].y = 135;
         a[2].x = 170;
         a[2].y = 135;
         a[3].x = 240;
         a[3].y = 135;
         a[4].x = 295;
         a[4].y = 135;
         a[5].x = 350;
         a[5].y = 135;
         a[6].x = 420;
         a[6].y = 135;
         a[7].x = 475;
         a[7].y = 135;
         a[8].x = 530;
         a[8].y = 135;
         a[9].x = 60;
         a[9].y = 190;
         a[10].x = 115;
         a[10].y = 190;
         a[11].x = 170;
         a[11].y = 190;
         a[12].x = 240;
         a[12].y = 190;
         a[13].x = 295;
         a[13].y = 190;
         a[14].x = 350;
         a[14].y = 190;
         a[15].x = 420;
         a[15].y = 190;
         a[16].x = 475;
         a[16].y = 190;
         a[17].x = 530;
         a[17].y = 190;
         a[18].x = 240;
         a[18].y = 80;
         a[19].x = 295;
         a[19].y = 80;
         a[20].x = 350;
         a[20].y = 80;
         a[21].x = 47;
         a[21].y = 245;
         a[22].x = 102;
         a[22].y = 245;
         a[23].x = 157;
         a[23].y = 245;
         a[24].x = 212;
         a[24].y = 245;
         a[25].x = 267;
         a[25].y = 245;
         a[26].x = 322;
         a[26].y = 245;
         a[27].x = 377;
         a[27].y = 245;
         a[28].x = 432;
         a[28].y = 245;
         a[29].x = 487;
         a[29].y = 245;
         a[30].x = 542;
         a[30].y = 245;
         a[31].x = 150;
         a[31].y = 355;
         a[32].x = 205;
         a[32].y = 355;
         a[33].x = 260;
         a[33].y = 355;
         a[34].x = 330;
         a[34].y = 355;
         a[35].x = 385;
         a[35].y = 355;
         a[36].x = 440;
         a[36].y = 355;
         a[37].x = 150;
         a[37].y = 410;
         a[38].x = 205;
         a[38].y = 410;
         a[39].x = 260;
         a[39].y = 410;
         a[40].x = 330;
         a[40].y = 410;
         a[41].x = 385;
         a[41].y = 410;
         a[42].x = 440;
         a[42].y = 410;
         a[43].x = 240;
         a[43].y = 300;
         a[44].x = 295;
         a[44].y = 300;
         a[45].x = 350;
         a[45].y = 300;
         add(new Entity(0,0,this._fade_image));
         super.begin();
      }
      
      override public function end() : void
      {
         removeAll();
         super.end();
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
         Button.resolveActions();
         if(Input.mousePressed || Input.pressed(Key.ESCAPE))
         {
            this.fadeOut(function():void
            {
               Globals.showStartWorld();
            });
         }
         super.update();
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

