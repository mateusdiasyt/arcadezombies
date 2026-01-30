package entities
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import utils.SuperText;
   
   public class FlashMessage extends Entity
   {
      
      public static var stack:Array = new Array();
      
      public static var playing:Boolean = false;
      
      public static var current_message:FlashMessage = null;
      
      private var text:SuperText;
      
      private var image:Image;
      
      private var duration:Number = 0;
      
      private var duration_timer:Number = 0;
      
      private var timer:Number = 0;
      
      private var display_timer:Number = 0;
      
      private var ticks:Number = 25;
      
      private var between_ticks:Number = 0;
      
      public function FlashMessage(text:String, duration:Number, image:Image = null)
      {
         super();
         this.layer = Const.FLASH_LAYER;
         Text.size = 20 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this.text = new SuperText(text,0,0,{
            "outlineColor":0,
            "outlineStrength":5
         });
         this.text.color = 16775392;
         this.image = image;
         if(Boolean(this.image))
         {
            this.text.y = (this.image.height - this.text.height) / 2;
            this.text.x = 0;
            this.image.x = this.text.width + 2;
         }
         this.duration = duration;
         this.between_ticks = 1 / this.ticks;
      }
      
      public static function addMessage(text:String, duration:Number, image:Image = null) : void
      {
         trace("Flash Msg: " + text);
         stack.push(new FlashMessage(text,duration,image));
         if(!playing)
         {
            FlashMessage.playing = true;
            FP.world.add(FlashMessage.current_message = stack[0]);
            FlashMessage.stack.splice(0,1);
         }
      }
      
      public static function reset() : void
      {
         current_message = null;
         playing = false;
         stack = new Array();
      }
      
      override public function added() : void
      {
         SoundManager.playSound(Assets.SFX_ACHIEVEMENT);
         if(this.image == null)
         {
            this.y = 2;
            this.x = (480 - this.text.width) / 2 + 7;
            this.graphic = this.text;
         }
         else
         {
            this.y = 2;
            this.x = (480 - (this.text.width + this.image.width + 2)) / 2 + 7;
            this.graphic = new Graphiclist(this.image,this.text);
         }
      }
      
      override public function removed() : void
      {
         super.removed();
         FlashMessage.playing = false;
      }
      
      override public function update() : void
      {
         this.timer += FP.elapsed;
         this.duration_timer += FP.elapsed;
         if(this.duration_timer > this.duration)
         {
            if(this.timer > this.between_ticks)
            {
               this.timer = 0;
               this.text.alpha -= 1 / this.ticks;
               if(Boolean(this.image))
               {
                  this.image.alpha -= 1 / this.ticks;
               }
            }
            if(this.text.alpha <= 0)
            {
               if(FlashMessage.stack.length > 0)
               {
                  FlashMessage.playing = true;
                  FP.world.add(FlashMessage.current_message = stack[0]);
                  FlashMessage.stack.splice(0,1);
               }
               else
               {
                  FlashMessage.current_message = null;
                  playing = false;
               }
               FP.world.remove(this);
            }
         }
         super.update();
      }
   }
}

