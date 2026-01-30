package spill.localisation
{
   import flash.xml.XMLNode;
   
   use namespace spil_internal;
   
   public class Languages
   {
      
      public static var languages:Object = new Object();
      
      private static var _init:Boolean = false;
      
      public function Languages()
      {
         super();
      }
      
      public static function initialize() : void
      {
         var _loc1_:Language = null;
         if(_init)
         {
            return;
         }
         _init = true;
         _loc1_ = new Language("nl");
         _loc1_.displayName = "Nederlands";
         _loc1_.p_family = "www.spelletjes.nl";
         _loc1_.p_tween = "www.spel.nl";
         _loc1_.p_girl = "www.girlsgogames.nl";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.p_hyves = "www.zapapa.nl";
         _loc1_.bwcId = 3;
         addLanguage(_loc1_);
         _loc1_ = new Language("es");
         _loc1_.displayName = "Español";
         _loc1_.p_family = "www.juegos.com";
         _loc1_.p_tween = "www.zapjuegos.com";
         _loc1_.p_girl = "www.girlsgogames.es";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 9;
         addLanguage(_loc1_);
         _loc1_ = new Language("pl");
         _loc1_.displayName = "Polski";
         _loc1_.p_family = "www.gry.pl";
         _loc1_.p_tween = "www.gry.pl";
         _loc1_.p_girl = "www.girlsgogames.pl";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 6;
         addLanguage(_loc1_);
         _loc1_ = new Language("fr");
         _loc1_.displayName = "Français";
         _loc1_.p_family = "www.jeux.fr";
         _loc1_.p_tween = "www.jeu.fr";
         _loc1_.p_girl = "www.girlsgogames.fr";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 4;
         addLanguage(_loc1_);
         _loc1_ = new Language("en_us","us");
         _loc1_.displayName = "English";
         _loc1_.p_family = "www.gamesgames.com";
         _loc1_.p_tween = "www.agame.com";
         _loc1_.p_girl = "www.girlsgogames.com";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 1;
         addLanguage(_loc1_);
         addReference(_loc1_,"en");
         _loc1_ = new Language("id");
         _loc1_.displayName = "Bahasa Ind.";
         _loc1_.p_family = "www.games.co.id";
         _loc1_.p_tween = "www.games.co.id";
         _loc1_.p_girl = "www.games.co.id";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 11;
         addLanguage(_loc1_);
         _loc1_ = new Language("ru");
         _loc1_.displayName = "Русский";
         _loc1_.p_family = "www.ourgames.ru";
         _loc1_.p_tween = "www.flashgames.ru";
         _loc1_.p_girl = "www.girlsgogames.ru";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 12;
         addLanguage(_loc1_);
         _loc1_ = new Language("se");
         _loc1_.displayName = "Svenska";
         _loc1_.p_family = "www.spela.se";
         _loc1_.p_tween = "www.spel.se";
         _loc1_.p_girl = "www.girlsgogames.se";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 7;
         addLanguage(_loc1_);
         addReference(_loc1_,"sv");
         _loc1_ = new Language("it");
         _loc1_.displayName = "Italiano";
         _loc1_.p_family = "www.gioco.it";
         _loc1_.p_girl = "www.girlsgogames.it";
         _loc1_.p_teen = "www.a10.it";
         _loc1_.p_tween = "www.giochi.it";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 8;
         addLanguage(_loc1_);
         _loc1_ = new Language("en_uk","uk");
         _loc1_.displayName = "English";
         _loc1_.p_family = "www.games.co.uk";
         _loc1_.p_tween = "www.agame.com";
         _loc1_.p_girl = "www.girlsgogames.co.uk";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 13;
         addLanguage(_loc1_);
         _loc1_ = new Language("cn");
         _loc1_.displayName = "中文";
         _loc1_.p_family = "www.game.com.cn";
         _loc1_.p_tween = "www.game.com.cn";
         _loc1_.p_girl = "www.game.com.cn";
         _loc1_.p_teen = "www.game.com.cn";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 2;
         _loc1_.embedInputFonts = false;
         addLanguage(_loc1_);
         addReference(_loc1_,"zh-CN");
         addReference(_loc1_,"zh-TW");
         _loc1_ = new Language("pt");
         _loc1_.displayName = "Português";
         _loc1_.p_family = "www.ojogos.pt";
         _loc1_.p_tween = "www.ojogos.pt";
         _loc1_.p_girl = "www.ojogos.pt";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 17;
         addLanguage(_loc1_);
         _loc1_ = new Language("in");
         _loc1_.displayName = "English";
         _loc1_.p_family = "www.game.co.in";
         _loc1_.p_tween = "www.game.co.in";
         _loc1_.p_girl = "www.game.co.in";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.textLanguage = "en_uk";
         _loc1_.bwcId = 14;
         addLanguage(_loc1_);
         _loc1_ = new Language("de");
         _loc1_.displayName = "Deutsch";
         _loc1_.p_family = "www.jetztspielen.de";
         _loc1_.p_tween = "www.spielen.com";
         _loc1_.p_girl = "www.girlsgogames.de";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 5;
         addLanguage(_loc1_);
         _loc1_ = new Language("br");
         _loc1_.displayName = "Português (BR)";
         _loc1_.p_family = "www.ojogos.com.br";
         _loc1_.p_tween = "www.clickjogos.com";
         _loc1_.p_girl = "www.girlsgogames.com.br";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 10;
         addLanguage(_loc1_);
         _loc1_ = new Language("jp");
         _loc1_.displayName = "日本語";
         _loc1_.p_family = "www.egames.jp";
         _loc1_.p_tween = "www.egames.jp";
         _loc1_.p_girl = "www.egames.jp";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.embedInputFonts = false;
         _loc1_.bwcId = 19;
         addLanguage(_loc1_);
         addReference(_loc1_,"ja");
         _loc1_ = new Language("ar");
         _loc1_.displayName = "English";
         _loc1_.p_family = "www.dailygame.com";
         _loc1_.p_tween = "www.dailygame.com";
         _loc1_.p_girl = "www.dailygame.com";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         _loc1_.bwcId = 20;
         addLanguage(_loc1_);
         addReference(_loc1_,"ar");
         _loc1_ = new Language("es_mx","mx");
         _loc1_.displayName = "Español (mx)";
         _loc1_.p_family = "www.juegos.mx";
         _loc1_.p_tween = "www.juegos.mx";
         _loc1_.p_girl = "www.juegosdechicas.mx";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         addLanguage(_loc1_);
         addReference(_loc1_,"mx");
         _loc1_ = new Language("es_ar","arg");
         _loc1_.displayName = "Español (ar)";
         _loc1_.p_family = "www.juegos.com.ar";
         _loc1_.p_tween = "www.juegos.com.ar";
         _loc1_.p_girl = "www.juegosdechicas.com.ar";
         _loc1_.p_teen = "www.a10.com";
         _loc1_.p_zapapa = "www.zapapa.com";
         addLanguage(_loc1_);
         addReference(_loc1_,"arg");
      }
      
      private static function addReference(param1:Language, param2:String) : void
      {
         languages[param2] = param1;
         param1.references.push(param2);
      }
      
      private static function addLanguage(param1:Language) : void
      {
         languages[param1.name] = param1;
      }
      
      public static function getLanguage(param1:String) : Language
      {
         return languages[param1];
      }
      
      public static function getLanguageByOldID(param1:int) : Language
      {
         var _loc2_:Language = null;
         for each(_loc2_ in languages)
         {
            if(_loc2_.bwcId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getLanguagesArray() : Array
      {
         var _loc3_:Language = null;
         var _loc1_:Array = new Array();
         var _loc2_:Object = new Object();
         for each(_loc3_ in languages)
         {
            if(!_loc2_[_loc3_.name])
            {
               _loc1_.push(_loc3_);
               _loc2_[_loc3_.name] = true;
            }
         }
         return _loc1_;
      }
      
      public static function exportXML() : XMLNode
      {
         var _loc3_:Language = null;
         var _loc1_:Array = getLanguagesArray();
         var _loc2_:XMLNode = new XMLNode(1,"languages");
         for each(_loc3_ in _loc1_)
         {
            _loc2_.appendChild(_loc3_.exportXML());
         }
         return _loc2_;
      }
   }
}

