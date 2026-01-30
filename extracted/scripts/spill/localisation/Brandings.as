package spill.localisation
{
   use namespace spil_internal;
   
   public class Brandings
   {
      
      private static var brands_by_id:Object = new Object();
      
      private static var brands_by_domain:Object = new Object();
      
      public function Brandings()
      {
         super();
      }
      
      public static function initialize() : void
      {
         var _loc1_:Brand = null;
         _loc1_ = new Brand();
         _loc1_.site_id = 79;
         _loc1_.domain = "www.agame.com";
         _loc1_.preferedLanguage = "en_us";
         _loc1_.portalGroup = PortalGroup.TEENS;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 88;
         _loc1_.domain = "www.gamesgames.com";
         _loc1_.preferedLanguage = "en_us";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 90;
         _loc1_.domain = "www.girlsgogames.com";
         _loc1_.preferedLanguage = "en_us";
         _loc1_.portalGroup = PortalGroup.GIRL;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 45;
         _loc1_.domain = "www.a10.com";
         _loc1_.preferedLanguage = "en_us";
         _loc1_.portalGroup = PortalGroup.YOUNG_ADULTS;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 92;
         _loc1_.domain = "www.games.co.uk";
         _loc1_.preferedLanguage = "en_uk";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 107;
         _loc1_.domain = "www.agame.co.uk";
         _loc1_.preferedLanguage = "en_uk";
         _loc1_.portalGroup = PortalGroup.TEENS;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 138;
         _loc1_.domain = "www.giochi.it";
         _loc1_.preferedLanguage = "it";
         _loc1_.portalGroup = PortalGroup.TEENS;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 102;
         _loc1_.domain = "www.girlsgogames.co.uk";
         _loc1_.preferedLanguage = "en_uk";
         _loc1_.portalGroup = PortalGroup.GIRL;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 2;
         _loc1_.domain = "www.game.com.cn";
         _loc1_.moreLink = "moregames/";
         _loc1_.preferedLanguage = "cn";
         _loc1_.portalGroup = PortalGroup.NONE;
         _loc1_.useGoogleAnalitics = false;
         _loc1_.hasSendToFriendLink = false;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 25;
         _loc1_.domain = "www.spel.nl";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "nl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 1;
         _loc1_.domain = "www.spelletjes.nl";
         _loc1_.emailLink = "spel";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "nl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 93;
         _loc1_.domain = "www.girlsgogames.nl";
         _loc1_.emailLink = "spel";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "nl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 12;
         _loc1_.domain = "www.jeu.fr";
         _loc1_.emailLink = "jeu";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "fr";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 95;
         _loc1_.domain = "www.girlsgogames.fr";
         _loc1_.emailLink = "jeu";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "fr";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 11;
         _loc1_.domain = "www.jeux.fr";
         _loc1_.emailLink = "jeu";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "fr";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 26;
         _loc1_.domain = "www.spielen.com";
         _loc1_.emailLink = "spiel";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "de";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 94;
         _loc1_.domain = "www.girlsgogames.de";
         _loc1_.emailLink = "spiel";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "de";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 5;
         _loc1_.domain = "www.jetztspielen.de";
         _loc1_.emailLink = "spiel";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "de";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 109;
         _loc1_.domain = "www.minigry.pl";
         _loc1_.emailLink = "gra";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "pl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 16;
         _loc1_.domain = "www.gry.pl";
         _loc1_.emailLink = "gra";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "pl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 98;
         _loc1_.domain = "www.girlsgogames.pl";
         _loc1_.emailLink = "gra";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "pl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 108;
         _loc1_.domain = "www.spel.se";
         _loc1_.emailLink = "spel_";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "se";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 100;
         _loc1_.domain = "www.girlsgogames.se";
         _loc1_.emailLink = "spel_";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "se";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 44;
         _loc1_.domain = "www.spela.se";
         _loc1_.emailLink = "spel_";
         _loc1_.preferedLanguage = "se";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 106;
         _loc1_.domain = "www.giocaregratis.it";
         _loc1_.emailLink = "gioco";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "it";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 15;
         _loc1_.domain = "www.gioco.it";
         _loc1_.emailLink = "gioco";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "it";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 99;
         _loc1_.domain = "www.girlsgogames.it";
         _loc1_.emailLink = "gioco";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "it";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 97;
         _loc1_.domain = "www.zapjuegos.com";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 86;
         _loc1_.domain = "www.juegos.com";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 96;
         _loc1_.domain = "www.juegosdechicas.com";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 122;
         _loc1_.domain = "www.girlsgogames.es";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 125;
         _loc1_.domain = "www.juegos.mx";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 126;
         _loc1_.domain = "www.juegosdechicas.mx";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 127;
         _loc1_.domain = "www.juegos.com.ar";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 128;
         _loc1_.domain = "www.juegosdechicas.com.ar";
         _loc1_.emailLink = "juego";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "es";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 91;
         _loc1_.domain = "www.clickjogos.com";
         _loc1_.emailLink = "jogo";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "br";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 101;
         _loc1_.domain = "www.girlsgogames.com.br";
         _loc1_.emailLink = "jogo";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "br";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 50;
         _loc1_.domain = "www.ojogos.com.br";
         _loc1_.emailLink = "jogo";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "br";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 55;
         _loc1_.domain = "www.games.co.id";
         _loc1_.emailLink = "permainanme";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "id";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 105;
         _loc1_.domain = "www.flashgames.ru";
         _loc1_.emailLink = "igra";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "ru";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 104;
         _loc1_.domain = "www.girlsgogames.ru";
         _loc1_.emailLink = "igra";
         _loc1_.portalGroup = PortalGroup.GIRL;
         _loc1_.preferedLanguage = "ru";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 103;
         _loc1_.domain = "www.ourgames.ru";
         _loc1_.emailLink = "igra";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "ru";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 24;
         _loc1_.domain = "www.game.co.in";
         _loc1_.emailLink = "game";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "in";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 87;
         _loc1_.domain = "www.ojogos.pt";
         _loc1_.emailLink = "jogo";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "pt";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 120;
         _loc1_.domain = "www.egames.jp";
         _loc1_.emailLink = "game";
         _loc1_.portalGroup = PortalGroup.TEENS;
         _loc1_.preferedLanguage = "jp";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 121;
         _loc1_.domain = "www.dailygame.com";
         _loc1_.emailLink = "/game/";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "en_us";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 123;
         _loc1_.domain = "www.zapapa.com";
         _loc1_.emailLink = "game";
         _loc1_.portalGroup = PortalGroup.ZAPAPA;
         _loc1_.preferedLanguage = "en_us";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 124;
         _loc1_.domain = "www.zapapa.nl";
         _loc1_.emailLink = "game";
         _loc1_.portalGroup = PortalGroup.HYVES;
         _loc1_.preferedLanguage = "nl";
         addBrand(_loc1_);
         _loc1_ = new Brand();
         _loc1_.site_id = 0;
         _loc1_.domain = "gamedev.dev.spilgames.com";
         _loc1_.portalGroup = PortalGroup.FAMILY;
         _loc1_.preferedLanguage = "en_us";
         addBrand(_loc1_);
      }
      
      public static function hasDomain(param1:String) : Boolean
      {
         return brands_by_domain[param1] != null;
      }
      
      public static function getBrandByDomain(param1:String) : Brand
      {
         return brands_by_domain[param1];
      }
      
      public static function getBrandByID(param1:Number) : Brand
      {
         return brands_by_id[param1];
      }
      
      private static function addBrand(param1:Brand) : Brand
      {
         if(Boolean(brands_by_domain[param1.domain]))
         {
            trace("ERROR: Attempting to add duplicate brand by domain: " + param1.domain);
         }
         else
         {
            brands_by_domain[param1.domain] = param1;
         }
         if(Boolean(brands_by_id[param1.site_id]))
         {
            trace("ERROR: Attempting to add duplicate brand by id: " + param1.site_id);
         }
         else
         {
            brands_by_id[param1.site_id] = param1;
         }
         return param1;
      }
      
      public static function getBrandsArray() : Array
      {
         var _loc2_:Brand = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in brands_by_domain)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public static function exportXML() : XML
      {
         var _loc2_:Brand = null;
         var _loc1_:XML = <portals/>;
         for each(_loc2_ in brands_by_domain)
         {
            _loc1_.appendChild(_loc2_.exportXML());
         }
         return _loc1_;
      }
   }
}

