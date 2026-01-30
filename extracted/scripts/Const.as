package
{
   public class Const
   {
      
      public static const TILE_WIDTH:Number = 30;
      
      public static const TILE_HEIGHT:Number = 30;
      
      public static var FONT:String = "JezzabelBimbo";
      
      public static var FONT_TEXT:String = "Exoteric";
      
      public static var FONT_OFFSET:Number = 1;
      
      public static const WALK:String = "walk";
      
      public static const FROZEN_WALK:String = "frozen walk";
      
      public static const HIT1:String = "hit1";
      
      public static const HIT2:String = "hit2";
      
      public static const FROZEN_HIT1:String = "frozen hit1";
      
      public static const FROZEN_HIT2:String = "frozen hit2";
      
      public static const EASY:Number = 0;
      
      public static const NORMAL:Number = 1;
      
      public static const HARD:Number = 2;
      
      public static const INSANE:Number = 3;
      
      /** Elos / ranks (substituem dificuldade no modo ranking) */
      public static const BRONZE:Number = 0;
      public static const SILVER:Number = 1;
      public static const GOLD:Number = 2;
      public static const PLATINUM:Number = 3;
      public static const DIAMOND:Number = 4;
      public static const MASTER:Number = 5;
      
      /** Multiplicador de dificuldade por elo: Bronze=1, Prata=2, Ouro=4, Platina=8, Diamante=16, Mestre=32 */
      public static function getDifficultyMultiplierForRank(rank:Number) : Number
      {
         if(rank <= BRONZE) return 1;
         if(rank <= SILVER) return 2;
         if(rank <= GOLD) return 4;
         if(rank <= PLATINUM) return 8;
         if(rank <= DIAMOND) return 16;
         return 32;
      }
      
      /** Faixas de PDL por elo: Bronze 0-100, Prata 100-200, Ouro 200-400, Platina 400-800, Diamante 800-1600, Mestre 1600-3200 */
      public static function getRankFromPDL(pdl:Number) : Number
      {
         if(pdl < 100) return BRONZE;
         if(pdl < 200) return SILVER;
         if(pdl < 400) return GOLD;
         if(pdl < 800) return PLATINUM;
         if(pdl < 1600) return DIAMOND;
         return MASTER;
      }
      
      public static const maps:Object = {
         "EasyMap":Assets.OEL_EASYMAP,
         "NormalMap":Assets.OEL_NORMALMAP,
         "HardMap":Assets.OEL_HARDMAP,
         "InsaneMap":Assets.OEL_INSANEMAP
      };
      
      /** Mapa usado por elo (Bronze=Easy, Silver=Normal, Gold=Hard, Platinum/Diamond/Master=Insane) */
      public static function getMapNameForRank(rank:Number) : String
      {
         if(rank <= BRONZE) return "EasyMap";
         if(rank <= SILVER) return "NormalMap";
         if(rank <= GOLD) return "HardMap";
         return "InsaneMap";
      }
      
      public static const WIN_LOSE_LAYER:int = -200;
      
      public static const FLASH_LAYER:int = 0;
      
      public static const TOOLTIP_LAYER:int = 100;
      
      public static const OPTION_MENU_LAYER:int = 200;
      
      public static const VALUE_POP_LAYER:int = 300;
      
      public static const HUD_LAYER:int = 350;
      
      public static const EFFECTS_LAYER:int = 400;
      
      public static const FLAME_THROWER_LAYER:int = 500;
      
      public static const BEAM_LAYER:int = 500;
      
      public static const BULLET_LAYER:int = 500;
      
      public static const TOWER_LAYER:int = 1000;
      
      public static const HEALTH_BAR_LAYER:int = 1500;
      
      public static const ZOMBIE_LAYER:int = 2000;
      
      public static const BLOOD_SPLATTER_LAYER:int = 3000;
      
      public static const RANGE_CIRLCE_LAYER:int = 4000;
      
      public function Const()
      {
         super();
      }
   }
}

