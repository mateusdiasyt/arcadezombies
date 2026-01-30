package spill.localisation
{
   import flash.xml.XMLNode;
   
   use namespace spil_internal;
   
   public class Brand
   {
      
      private static const topLevelDoubles:String = "ac.cn,ac.jp,ac.uk,ad.jp,adm.br,adv.br,agr.br," + "ah.cn,am.br,arq.br,art.br,asn.au,ato.br,av.tr,bel.tr,bio.br,biz.tr,bj.cn,bmd.br," + "cim.br,cng.br,cnt.br,co.at,co.jp,co.uk,com.au,com.br,com.cn,com.eg,com.hk,com.mx," + "com.ru,com.tr,com.tw,conf.au,cq.cn,csiro.au,dr.tr,ecn.br,edu.au,edu.br,edu.tr," + "emu.id.au,eng.br,esp.br,etc.br,eti.br,eun.eg,far.br,fj.cn,fm.br,fnd.br,fot.br," + "fst.br,g12.br,gb.com,gb.net,gd.cn,gen.tr,ggf.br,gob.mx,gov.au,gov.br,gov.cn," + "gov.hk,gov.tr,gr.jp,gs.cn,gx.cn,gz.cn,ha.cn,hb.cn,he.cn,hi.cn,hk.cn,hl.cn,hn.cn," + "id.au,idv.tw,imb.br,ind.br,inf.br,info.au,info.tr,jl.cn,jor.br,js.cn,jx.cn,k12.tr," + "lel.br,ln.cn,ltd.uk,mat.br,me.uk,med.br,mil.br,mil.tr,mo.cn,mus.br,name.tr,ne.jp," + "net.au,net.br,net.cn,net.eg,net.hk,net.lu,net.mx,net.ru,net.tr,net.tw,net.uk," + "nm.cn,no.com,nom.br,not.br,ntr.br,nx.cn,odo.br,oop.br,or.at,or.jp,org.au,org.br," + "org.cn,org.hk,org.lu,org.ru,org.tr,org.tw,org.uk,plc.uk,pol.tr,pp.ru,ppg.br,pro.br," + "psc.br,psi.br,qh.cn,qsl.br,rec.br,sc.cn,sd.cn,se.com,se.net,sh.cn,slg.br,sn.cn," + "srv.br,sx.cn,tel.tr,tj.cn,tmp.br,trd.br,tur.br,tv.br,tw.cn,uk.com,uk.net,vet.br," + "wattle.id.au,web.tr,xj.cn,xz.cn,yn.cn,zj.cn,zlg.br,co.nr,co.nz,com.fr,com.ph,com.ar," + "com.id,com.in";
      
      public var domain:String;
      
      public var site_id:uint;
      
      public var moreLink:String = "";
      
      public var emailLink:String = "game";
      
      public var emailPage:String;
      
      public var id:Number;
      
      public var name:String;
      
      public var portalGroup:uint;
      
      public var useGoogleAnalitics:Boolean = true;
      
      public var hasSendToFriendLink:Boolean = true;
      
      public var preferedLanguage:String = "";
      
      public var isExternal:Boolean = false;
      
      public var hostingDomain:String = "";
      
      public function Brand()
      {
         super();
      }
      
      public static function stripSubDomain(param1:String) : String
      {
         if(!param1)
         {
            return "";
         }
         var _loc2_:Array = param1.split(".");
         if(_loc2_.length <= 2)
         {
            return param1;
         }
         _loc2_ = _loc2_.reverse();
         if(topLevelDoubles.indexOf(_loc2_[1] + "." + _loc2_[0] + ",") > 0)
         {
            return _loc2_[2] + "." + _loc2_[1] + "." + _loc2_[0];
         }
         return _loc2_[1] + "." + _loc2_[0];
      }
      
      public function getMoreGamesLink(param1:String, param2:Boolean, param3:String = "", param4:String = "") : String
      {
         var _loc5_:String = "http://" + domain;
         _loc5_ += "/" + moreLink;
         if(useGoogleAnalitics)
         {
            _loc5_ += "?utm_medium=brandedgames_" + (param2 ? "external" : "internal");
            _loc5_ += "&utm_campaign=" + param1;
            param3 = stripSubDomain(param3);
            if(param3 == "localhost")
            {
               param3 = "offline_play";
            }
            _loc5_ += "&utm_source=" + param3;
            if(param4 != "" && param4 != null)
            {
               _loc5_ += "&utm_content=" + param4;
            }
         }
         return _loc5_;
      }
      
      public function getSendToFriendLink(param1:String, param2:String, param3:Boolean, param4:String = "") : String
      {
         if(!hasSendToFriendLink)
         {
            return getMoreGamesLink(param1,param3);
         }
         var _loc5_:String = "http://" + domain;
         _loc5_ += "/" + emailLink + "/" + param2;
         if(useGoogleAnalitics)
         {
            _loc5_ += "?utm_medium=brandedgames_" + (param3 ? "external" : "internal");
            _loc5_ += "&utm_campaign=" + param1;
            param4 = stripSubDomain(param4);
            if(param4 == "localhost")
            {
               param4 = "offline_play";
            }
            _loc5_ += "&utm_source=" + param4;
            _loc5_ += "&utm_content=send_to_friend";
         }
         return _loc5_;
      }
      
      public function getPromotionLink(param1:String, param2:String, param3:Boolean, param4:String = "", param5:String = "") : String
      {
         var _loc6_:String = "http://" + domain;
         _loc6_ += "/" + emailLink + "/" + param2;
         if(useGoogleAnalitics)
         {
            _loc6_ += "?utm_medium=brandedgames_" + (param3 ? "external" : "internal");
            _loc6_ += "&utm_campaign=" + param1;
            param4 = stripSubDomain(param4);
            trace(param4);
            if(param4 == "localhost")
            {
               param4 = "offline_play";
            }
            _loc6_ += "&utm_source=" + param4;
            if(param5 != "" && param5 != null)
            {
               _loc6_ += "&utm_content=" + param5;
            }
         }
         return _loc6_;
      }
      
      public function get backgroundColor() : uint
      {
         return PortalGroup.backgroundColors[portalGroup];
      }
      
      public function exportXML() : XML
      {
         var _loc3_:XML = null;
         var _loc1_:XML = <portal/>;
         _loc1_.@id = site_id;
         _loc1_.@language = preferedLanguage;
         _loc1_.@channel = portalGroup;
         var _loc2_:XML = <domain/>;
         _loc2_.appendChild(new XMLNode(3,domain));
         _loc1_.appendChild(_loc2_);
         if(Boolean(moreLink))
         {
            _loc3_ = <more_games_path/>;
            _loc3_.appendChild(new XMLNode(3,moreLink));
            _loc1_.appendChild(_loc3_);
         }
         _loc2_ = <game_path/>;
         _loc2_.appendChild(new XMLNode(3,emailLink));
         _loc1_.appendChild(_loc2_);
         if(!useGoogleAnalitics)
         {
            _loc1_.attributes.noGoogleAnalitics = true;
         }
         if(!hasSendToFriendLink)
         {
            _loc1_.attributes.noSendToFriendLink = true;
         }
         return _loc1_;
      }
      
      public function importXML(param1:XMLNode) : void
      {
      }
      
      private function get utm_source() : String
      {
         return "utm_source=brandedgames_" + (isExternal ? "external" : "internal");
      }
      
      private function get utm_term() : String
      {
         return "utm_term=";
      }
      
      private function get utm_campaign() : String
      {
         if(isExternal)
         {
            return "utm_campaign=" + hostingDomain;
         }
         return "";
      }
   }
}

