package
{
   import entities.TowerEntity;
   import entities.zombies.*;
   import flash.utils.describeType;
   import spill.localisation.SpilGame;
   
   public class Localizer
   {
      
      private static var instance:Localizer;
      
      public var branding_more_games_sentence_long:String = "Play more tower defense games at";
      
      public var branding_more_games_sentence_short:String = "More tower defense at";
      
      public var loading_loading:String = "Loading Game";
      
      public var loading_finish:String = "Game Loaded Click to Start";
      
      public var start_game_title:String = "Zombie TD: Reborn";
      
      public var start_new_game:String = "New Game";
      
      public var start_iniciar_partida:String = "Iniciar partida";
      
      public var start_ranking:String = "Ranking";
      
      public var start_medals:String = "Medals";
      
      public var start_credits:String = "Credits";
      
      public var start_scores:String = "Scores";
      
      public var ranking_title:String = "Ranking";
      
      public var ranking_pdl:String = "Seu PDL";
      
      public var ranking_elo:String = "Seu elo";
      
      public var ranking_voltar:String = "Voltar";
      
      public var rank_bronze:String = "Bronze";
      
      public var rank_silver:String = "Prata";
      
      public var rank_gold:String = "Ouro";
      
      public var rank_platinum:String = "Platina";
      
      public var rank_diamond:String = "Diamante";
      
      public var rank_master:String = "Mestre";
      
      public var pdl_ganhou:String = "+3 PDL";
      
      public var pdl_perdeu:String = "-2 PDL";
      
      public var end_vitoria:String = "Vitória!";
      
      public var end_derrota:String = "Derrota";
      
      public var end_pdl_atual:String = "PDL atual";
      
      public var end_elo:String = "Elo";
      
      public var difficulty_select:String = "Select Difficulty Level";
      
      public var difficulty_easy:String = "Easy";
      
      public var difficulty_normal:String = "Normal";
      
      public var difficulty_hard:String = "Hard";
      
      public var difficulty_hell:String = "Hell";
      
      public var tower_sentry:String = "Sentry";
      
      public var tower_cannon:String = "Cannon";
      
      public var tower_sam:String = "SAM";
      
      public var tower_sensor:String = "Sensor";
      
      public var tower_ice:String = "Ice";
      
      public var tower_minigun:String = "Minigun";
      
      public var tower_buzzsaw:String = "Buzzsaw";
      
      public var tower_fire:String = "Fire";
      
      public var tower_laser:String = "Laser";
      
      public var tower_hover_kills:String = "Kills";
      
      public var tower_hover_level:String = "Level";
      
      public var tower_hover_target:String = "Target";
      
      public var target_first:String = "First";
      
      public var target_last:String = "Last";
      
      public var target_weakest:String = "Weak";
      
      public var target_strongest:String = "Strong";
      
      public var target_air:String = "Air";
      
      public var tower_info_ground_only:String = "Ground Only";
      
      public var tower_info_air_only:String = "Air Only";
      
      public var tower_info_ground_air:String = "Ground and Air";
      
      public var tower_info_max:String = "Max";
      
      public var tower_info_max_upgrade:String = "Max Upgrade";
      
      public var tower_info_cost:String = "Cost";
      
      public var tower_info_damage:String = "Damage";
      
      public var tower_info_range:String = "Range";
      
      public var tower_info_speed:String = "Speed";
      
      public var tower_info_effects:String = "Effects";
      
      public var tower_info_very_long:String = "Very Long";
      
      public var tower_info_long:String = "Long";
      
      public var tower_info_medium:String = "Medium";
      
      public var tower_info_short:String = "Short";
      
      public var tower_info_none:String = "None";
      
      public var tower_info_low:String = "Low";
      
      public var tower_info_very_low:String = "Very Low";
      
      public var tower_info_average:String = "Average";
      
      public var tower_info_high:String = "High";
      
      public var tower_info_extreme:String = "Extreme";
      
      public var tower_info_very_slow:String = "Very Slow";
      
      public var tower_info_slow:String = "Slow";
      
      public var tower_info_normal:String = "Normal";
      
      public var tower_info_very_fast:String = "Very Fast";
      
      public var tower_info_burns:String = "Burns";
      
      public var tower_info_ignores_armor:String = "Ignores armor";
      
      public var tower_info_large_splash:String = "Large splash";
      
      public var tower_info_target_ground:String = "Targets ground at lv 3";
      
      public var tower_info_super_missile:String = "Super air missile at lv 5";
      
      public var tower_info_detect_invisible:String = "Detects invisible";
      
      public var tower_info_stuns:String = "Stuns at lv 4";
      
      public var tower_info_slows:String = "Slows";
      
      public var tower_info_small_splash:String = "Small Splash";
      
      public var tower_info_hits_multiple:String = "Hits multiple zombies";
      
      public var tower_info_target_air:String = "Targets air at lv 4";
      
      public var toolbar_increase_speed:String = "Increase game speed";
      
      public var toolbar_decrease_speed:String = "Decrease game speed";
      
      public var toolbar_options_menu:String = "View options menu";
      
      public var toolbar_mute_sfx:String = "Mute SFX";
      
      public var toolbar_unmute_sfx:String = "Unmute SFX";
      
      public var toolbar_mute_music:String = "Mute Music";
      
      public var toolbar_unmute_music:String = "Unmute Music";
      
      public var toolbar_next_level:String = "Call next level";
      
      public var toolbar_view_help:String = "View help";
      
      public var zombie_normal:String = "Normal Zombie";
      
      public var zombie_female:String = "Hot Dead Girl";
      
      public var zombie_strong:String = "Hulking Big Zombie";
      
      public var zombie_hound:String = "Hell Hound";
      
      public var zombie_invisible:String = "Ghostly Zombie";
      
      public var zombie_flying:String = "Flying Zombie";
      
      public var zombie_torso:String = "Creeping Torso";
      
      public var zombie_project_x:String = "Project X";
      
      public var zombie_devilish:String = "Devilish";
      
      public var zombie_hammer_time:String = "Hammer Time";
      
      public var zombie_info_life:String = "Life";
      
      public var zombie_info_armor:String = "Armor";
      
      public var zombie_info_bounty:String = "Bounty";
      
      public var zombie_info_flying:String = "Flying";
      
      public var zombie_info_invisible:String = "Invisible";
      
      public var zombie_info_no_special:String = "No Special Abilities";
      
      public var options_quit:String = "Quit";
      
      public var options_restart:String = "Restart";
      
      public var options_resume:String = "Resume Game";
      
      public var help_title:String = "Shortcuts";
      
      public var help_buy_sentry:String = "Buy Sentry";
      
      public var help_buy_cannon:String = "Buy Cannon";
      
      public var help_buy_sam:String = "Buy SAM";
      
      public var help_buy_sensor:String = "Buy Sensor";
      
      public var help_buy_ice:String = "Buy Ice";
      
      public var help_buy_minigun:String = "Buy Minigun";
      
      public var help_buy_buzzsaw:String = "Buy Buzzsaw";
      
      public var help_buy_flame:String = "Buy Flame";
      
      public var help_buy_laser:String = "Buy Laser";
      
      public var help_upgrade_tower:String = "Upgrade Tower";
      
      public var help_sell_tower:String = "Sell Tower";
      
      public var help_options_pause:String = "Options Menu / Pause";
      
      public var help_sell_title:String = "Tower Sell Values";
      
      public var help_call_early:String = "Calling waves early increases Zombie scores";
      
      public var upgrade:String = "Upgrade for";
      
      public var sell:String = "Sell for";
      
      public var medal_cannon_5:String = "Cannon Level 5 Medal Awarded";
      
      public var medal_bronze_champ:String = "Bronze Champion Medal Awarded";
      
      public var medal_burn:String = "Burn 100 Zombies Medal Awarded";
      
      public var medal_buzzsaw_5:String = "Buzzsaw Level 5 Medal Awarded";
      
      public var medal_early_100:String = "Call 100 Waves Early Medal Awarded";
      
      public var medal_early_20:String = "Call 20 Waves Early Medal Awarded";
      
      public var medal_early_50:String = "Call 50 Waves Early Medal Awarded";
      
      public var medal_easy_bronze:String = "Easy Bronze Medal Awarded";
      
      public var medal_easy_gold:String = "Easy Gold Medal Awarded";
      
      public var medal_easy_silver:String = "Easy Silver Medal Awarded";
      
      public var medal_fire_5:String = "Flamethrower Level 5 Medal Awarded";
      
      public var medal_freeze:String = "Freeze 100 Zombies Medal Awarded";
      
      public var medal_gold_champ:String = "Gold Champion Medal Awarded";
      
      public var medal_hard_bronze:String = "Hard Bronze Medal Awarded";
      
      public var medal_hard_silver:String = "Hard Silver Medal Awarded";
      
      public var medal_hard_gold:String = "Hard Gold Medal Awarded";
      
      public var medal_ice_5:String = "Ice Level 5 Medal Awarded";
      
      public var medal_insane_bronze:String = "Hell Bronze Medal Awarded";
      
      public var medal_insane_silver:String = "Hell Silver Medal Awarded";
      
      public var medal_insane_gold:String = "Hell Gold Medal Awarded";
      
      public var medal_killer_1000:String = "Kill 1000 Zombies Medal Awarded";
      
      public var medal_killer_250:String = "Kill 250 Zombies Medal Awarded";
      
      public var medal_killer_50:String = "Kill 50 Zombies Medal Awarded";
      
      public var medal_laser_5:String = "Laser Level 5 Medal Awarded";
      
      public var medal_normal_bronze:String = "Normal Bronze Medal Awarded";
      
      public var medal_normal_silver:String = "Normal Silver Medal Awarded";
      
      public var medal_normal_gold:String = "Normal Gold Medal Awarded";
      
      public var medal_minigun_5:String = "Minigun Level 5 Medal Awarded";
      
      public var medal_sam_5:String = "SAM Level 5 Medal Awarded";
      
      public var medal_score_1:String = "Score 25000 Medal Awarded";
      
      public var medal_score_2:String = "Score 50000 Medal Awarded";
      
      public var medal_score_3:String = "Score 100000 Medal Awarded";
      
      public var medal_sensor_5:String = "Sensor Level 5 Awarded";
      
      public var medal_sentry_5:String = "Sentry Level 5 Awarded";
      
      public var medal_silver_champ:String = "Silver Champion Medal Awarded";
      
      public var medal_spend_1000:String = "Spend 1000 Big Ones Medal Awarded";
      
      public var medal_spend_2500:String = "Spend 2500 Big Ones Medal Awarded";
      
      public var medal_spend_500:String = "Spend 500 Big Ones Medal Awarded";
      
      public var medal_stun_100:String = "Stun 100 Zombies Medal Awarded";
      
      public var medal_time_played_120:String = "120 Minutes Played Medal Awarded";
      
      public var medal_time_played_60:String = "60 Minutes Played Medal Awarded";
      
      public var medal_time_played_30:String = "30 Minutes Played Medal Awarded";
      
      public var medal_tower_champ:String = "Tower Champion Medal Awarded";
      
      public var medal_towers_10:String = "Purchase 10 Towers Medal Awarded";
      
      public var medal_towers_25:String = "Purchase 25 Towers Medal Awarded";
      
      public var medal_towers_50:String = "Purchase 50 Towers Medal Awarded";
      
      public var end_game_over:String = "Game Over";
      
      public var end_level_complete:String = "Level Completed";
      
      public var end_kills:String = "Kills";
      
      public var end_money:String = "Money";
      
      public var end_lives:String = "Lives";
      
      public var end_towers:String = "Towers";
      
      public var end_total:String = "Total";
      
      public var end_score:String = "SCORE";
      
      public var end_click_mouse:String = "Click Mouse to Continue";
      
      public var credits_graphics:String = "Graphics and Design by";
      
      public var credits_code:String = "Programming and Design by";
      
      public var credits_music:String = "Music and Sound by";
      
      public var credits_beta:String = "Special Thanks to Our Beta Testers";
      
      public var hud_money:String = "Money";
      
      public var hud_lives:String = "Lives";
      
      public var hud_level:String = "Level";
      
      public var hud_score:String = "Score";
      
      public function Localizer()
      {
         super();
      }
      
      public static function get Instance() : Localizer
      {
         if(instance == null)
         {
            instance = new Localizer();
         }
         return instance;
      }
      
      public function isDefault() : Boolean
      {
         if(SpilGame.currentLanguage.name == "en_us" || SpilGame.currentLanguage.name == "en_gb" || SpilGame.currentLanguage.name == "en_uk" || SpilGame.currentLanguage.name == "jp" || SpilGame.currentLanguage.name == "in" || SpilGame.currentLanguage.name == "ar" || SpilGame.currentLanguage.name == "cn")
         {
            return true;
         }
         return false;
      }
      
      public function update() : void
      {
         var n:XML = null;
         var name:String = null;
         if(Boolean(SpilGame.currentLanguage))
         {
            trace("Current Language: " + SpilGame.currentLanguage.name);
         }
         var xml:XML = describeType(this);
         var xl:XMLList = xml..variable;
         for each(n in xl)
         {
            name = n.@name;
            this[name] = SpilGame.getString(name);
            if(Boolean(this[name].indexOf("~")))
            {
               this[name] = this[name].replace("~","\n");
            }
         }
         if(Boolean(SpilGame.currentLanguage) && !this.isDefault())
         {
            Const.FONT = "Blah";
            Const.FONT_TEXT = "Blah";
            Const.FONT_OFFSET = 1.25;
         }
         else
         {
            Const.FONT = "JezzabelBimbo";
            Const.FONT_TEXT = "Exoteric";
            Const.FONT_OFFSET = 1;
         }
         TowerEntity.TARGET_FIRST = Localizer.Instance.target_first;
         TowerEntity.TARGET_LAST = Localizer.Instance.target_last;
         TowerEntity.TARGET_AIR = Localizer.Instance.target_air;
         TowerEntity.TARGET_STRONGEST = Localizer.Instance.target_strongest;
         TowerEntity.TARGET_WEAKEST = Localizer.Instance.target_weakest;
         DevilishBoss.NAME = Localizer.Instance.zombie_devilish;
         FemaleZombie.NAME = Localizer.Instance.zombie_female;
         FlyingZombie.NAME = Localizer.Instance.zombie_flying;
         HammerTimeBoss.NAME = Localizer.Instance.zombie_hammer_time;
         HellHound.NAME = Localizer.Instance.zombie_hound;
         InvisibleZombie.NAME = Localizer.Instance.zombie_invisible;
         NormalZombie.NAME = Localizer.Instance.zombie_normal;
         ProjectXBoss.NAME = Localizer.Instance.zombie_project_x;
         StrongZombie.NAME = Localizer.Instance.zombie_strong;
         TorsoZombie.NAME = Localizer.Instance.zombie_torso;
         Globals.resetWorlds();
         Towers.update();
         if(Boolean(Globals.tracker))
         {
            Globals.tracker.setupAchievements();
         }
      }
   }
}

