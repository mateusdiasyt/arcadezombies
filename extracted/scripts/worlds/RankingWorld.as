package worlds
{
   import entities.Button;
   import entities.buttons.GenericButton;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.World;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.graphics.Text;
   import utils.SuperText;
   
   public class RankingWorld extends World
   {
      
      private var _fade_image:Image = new Image(Assets.GFX_BLACK_BOX);
      
      private var _fade_timer:Number = 0;
      
      private var _fade_in:Boolean = true;
      
      public function RankingWorld()
      {
         super();
         Button.current_hover = null;
         Globals.loadPDL();
         add(new Entity(0,0,new Stamp(Assets.GFX_BACKGROUND_WINDOW)));
         Text.font = Const.FONT;
         Text.size = 28 / Const.FONT_OFFSET;
         var title:Text = new Text(Localizer.Instance.ranking_title);
         title.color = 0;
         add(new Entity((FP.width - title.width) / 2, 40, title));
         Text.size = 20 / Const.FONT_OFFSET;
         var pdlLine:Text = new Text(Localizer.Instance.ranking_pdl + ": " + Math.floor(Globals.pdl));
         pdlLine.color = 0;
         add(new Entity((FP.width - pdlLine.width) / 2, 120, pdlLine));
         var eloName:String = getRankName(Globals.rank);
         var eloLine:Text = new Text(Localizer.Instance.ranking_elo + ": " + eloName);
         eloLine.color = 0;
         add(new Entity((FP.width - eloLine.width) / 2, 160, eloLine));
         var voltar:GenericButton = new GenericButton(Localizer.Instance.ranking_voltar, 0, 0, function():void
         {
            Globals.showStartWorld();
         });
         voltar.x = (FP.width - 120) / 2;
         voltar.y = 250;
         add(voltar);
         add(new Entity(0,0,this._fade_image));
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
      
      override public function begin() : void
      {
         _fade_in = true;
         _fade_timer = 0;
         super.begin();
      }
      
      override public function update() : void
      {
         if(_fade_in)
         {
            _fade_timer += FP.elapsed;
            if(_fade_timer > 0.05)
            {
               _fade_timer = 0;
               _fade_image.alpha -= 0.1;
            }
            if(_fade_image.alpha <= 0)
               _fade_in = false;
         }
         super.update();
         Button.resolveActions();
      }
   }
}
