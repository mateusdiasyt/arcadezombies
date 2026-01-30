package entities
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.utils.Input;
   
   public class Button extends Entity
   {
      
      public static var button_list:Array = new Array();
      
      public static var current_hover:Button = null;
      
      public static var clickStack:Array = new Array();
      
      public static var mouseOverStack:Array = new Array();
      
      public static var mouseOutStack:Array = new Array();
      
      public var hovering:Boolean = false;
      
      public function Button()
      {
         super();
         Button.button_list.push(this);
      }
      
      public static function resolveActions() : void
      {
         var buttons:Array = null;
         var b:Button = null;
         if(clickStack.length > 0)
         {
            clickStack.sortOn("layer",Array.NUMERIC);
            clickStack[0].clickAction();
            clickStack.splice(0,clickStack.length);
            current_hover = null;
            buttons = Button.button_list;
            for each(b in buttons)
            {
               if(Boolean(b) && b.hovering)
               {
                  b.hovering = false;
               }
            }
         }
         if(mouseOverStack.length > 0)
         {
            mouseOverStack.sortOn("layer",Array.NUMERIC);
            mouseOverStack[0].mouseOver();
            mouseOverStack.splice(0,mouseOverStack.length);
         }
         if(mouseOutStack.length > 0)
         {
            mouseOutStack.sortOn("layer",Array.NUMERIC);
            mouseOutStack[0].mouseOut();
            mouseOutStack.splice(0,mouseOutStack.length);
         }
         if(Globals.escape_timer > 0)
         {
            Globals.escape_timer -= FP.elapsed;
         }
      }
      
      protected function hidden() : Boolean
      {
         return false;
      }
      
      public function clickAction() : void
      {
      }
      
      public function mouseOver() : void
      {
      }
      
      public function mouseOut() : void
      {
      }
      
      override public function update() : void
      {
         if(collidePoint(x,y,Input.mouseX,Input.mouseY))
         {
            if(!this.hidden() && !this.hovering && (Button.current_hover == null || Button.current_hover && Button.current_hover.layer > this.layer))
            {
               if(Boolean(Button.current_hover))
               {
                  Button.current_hover.hovering = false;
                  Button.mouseOutStack.push(Button.current_hover);
               }
               this.hovering = true;
               Button.current_hover = this;
               Button.mouseOverStack.push(this);
            }
            if(Input.mousePressed && !this.hidden())
            {
               Button.clickStack.push(this);
            }
         }
         else if(this.hovering && Button.current_hover == this)
         {
            this.hovering = false;
            Button.current_hover = null;
            Button.mouseOutStack.push(this);
         }
         super.update();
      }
   }
}

