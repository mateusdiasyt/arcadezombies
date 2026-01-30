package
{
   import entities.towers.bomb.*;
   import entities.towers.buzzsaw.*;
   import entities.towers.fire.*;
   import entities.towers.ice.*;
   import entities.towers.laser.*;
   import entities.towers.rapid.*;
   import entities.towers.sam.*;
   import entities.towers.sensor.*;
   import entities.towers.sentry.*;
   
   public class Towers
   {
      
      public static var sentry:Object = new Object();
      
      public static var bomb:Object = new Object();
      
      public static var sam:Object = new Object();
      
      public static var sensor:Object = new Object();
      
      public static var ice:Object = new Object();
      
      public static var fire:Object = new Object();
      
      public static var rapid:Object = new Object();
      
      public static var buzzsaw:Object = new Object();
      
      public static var laser:Object = new Object();
      
      sentry[1] = {
         "name":"Sentry Lv 1",
         "klass":SentryTower,
         "damage_display":"Average",
         "range_display":"Long",
         "speed_display":"Normal",
         "effect_display":"None",
         "ground":true,
         "air":true,
         "portrait_index":0,
         "range":75,
         "speed":0.5,
         "damage":5,
         "bullet_speed":5,
         "cost":10,
         "upgrade_cost":20,
         "upgrade_to":SentryTower2
      };
      sentry[2] = {
         "name":"Sentry Lv 2",
         "klass":SentryTower2,
         "range":85,
         "speed":0.5,
         "damage":14,
         "bullet_speed":5,
         "cost":10 + 20,
         "upgrade_cost":40,
         "upgrade_to":SentryTower3
      };
      sentry[3] = {
         "name":"Sentry Lv 3",
         "klass":SentryTower3,
         "range":95,
         "speed":0.5,
         "damage":32,
         "bullet_speed":5,
         "cost":10 + 20 + 40,
         "upgrade_cost":56,
         "upgrade_to":SentryTower4
      };
      sentry[4] = {
         "name":"Sentry Lv 4",
         "klass":SentryTower4,
         "range":105,
         "speed":0.5,
         "damage":56,
         "bullet_speed":5,
         "cost":10 + 20 + 40 + 56,
         "upgrade_cost":115,
         "upgrade_to":SentryTower5
      };
      sentry[5] = {
         "name":"Sentry Lv 5",
         "klass":SentryTower5,
         "range":115,
         "speed":0.5,
         "damage":110,
         "bullet_speed":5,
         "cost":10 + 20 + 40 + 56 + 115,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      bomb[1] = {
         "name":"Cannon Lv 1",
         "klass":BombTower,
         "damage_display":"Average",
         "range_display":"Short",
         "speed_display":"Normal",
         "effect_display":"Large Splash",
         "portrait_index":3,
         "ground":true,
         "air":false,
         "range":50,
         "speed":0.5,
         "damage":8,
         "damage_text":"8*",
         "splash_damage":2,
         "splash_range":20,
         "bullet_speed":5,
         "cost":14,
         "upgrade_cost":28,
         "upgrade_to":BombTower2
      };
      bomb[2] = {
         "name":"Cannon Lv 2",
         "klass":BombTower2,
         "ground":true,
         "air":false,
         "range":60,
         "speed":0.5,
         "damage":16,
         "damage_text":"16*",
         "bullet_speed":5,
         "splash_damage":4,
         "splash_range":25,
         "cost":14 + 28,
         "upgrade_cost":55,
         "upgrade_to":BombTower3
      };
      bomb[3] = {
         "name":"Cannon Lv 3",
         "klass":BombTower3,
         "ground":true,
         "air":false,
         "range":70,
         "speed":0.55,
         "damage":32,
         "damage_text":"32*",
         "bullet_speed":5,
         "splash_damage":8,
         "splash_range":30,
         "cost":14 + 28 + 55,
         "upgrade_cost":86,
         "upgrade_to":BombTower4
      };
      bomb[4] = {
         "name":"Cannon Lv 4",
         "klass":BombTower4,
         "ground":true,
         "air":false,
         "range":80,
         "speed":0.6,
         "damage":56,
         "damage_text":"56*",
         "bullet_speed":5,
         "splash_damage":18,
         "splash_range":35,
         "cost":14 + 28 + 55 + 86,
         "upgrade_cost":148,
         "upgrade_to":BombTower5
      };
      bomb[5] = {
         "name":"Cannon Lv 5",
         "klass":BombTower5,
         "ground":true,
         "air":false,
         "range":90,
         "speed":0.65,
         "damage":90,
         "damage_text":"90*",
         "bullet_speed":5,
         "splash_damage":35,
         "splash_range":40,
         "cost":14 + 28 + 55 + 86 + 148,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      sam[1] = {
         "name":"SAM Lv 1",
         "klass":SamTower,
         "damage_display":"Low",
         "range_display":"Very Long",
         "speed_display":"Normal",
         "effect_display":"Targets ground\nat lv3\nSuper air missile\nat lv 5",
         "portrait_index":6,
         "ground":false,
         "air":true,
         "range":75,
         "speed":0.5,
         "damage":6,
         "damage_text":"3x6",
         "bullet_speed":2,
         "max_targets":2,
         "total_missiles":3,
         "cost":12,
         "upgrade_cost":25,
         "upgrade_to":SamTower2
      };
      sam[2] = {
         "name":"SAM Lv 2",
         "klass":SamTower2,
         "ground":false,
         "air":true,
         "range":100,
         "speed":0.5,
         "damage":12,
         "damage_text":"5x12",
         "bullet_speed":2,
         "max_targets":3,
         "total_missiles":5,
         "cost":12 + 25,
         "upgrade_cost":55,
         "upgrade_to":SamTower3
      };
      sam[3] = {
         "name":"SAM Lv 3",
         "klass":SamTower3,
         "ground":true,
         "air":true,
         "range":125,
         "speed":0.5,
         "damage":15,
         "damage_text":"7x15",
         "bullet_speed":2,
         "max_targets":3,
         "total_missiles":7,
         "ground_missiles":2,
         "cost":12 + 25 + 55,
         "upgrade_cost":85,
         "upgrade_to":SamTower4
      };
      sam[4] = {
         "name":"SAM Lv 4",
         "klass":SamTower4,
         "ground":true,
         "air":true,
         "range":150,
         "speed":0.5,
         "damage":20,
         "damage_text":"9x20",
         "bullet_speed":2,
         "max_targets":5,
         "total_missiles":9,
         "ground_missiles":3,
         "cost":12 + 25 + 55 + 85,
         "upgrade_cost":165,
         "upgrade_to":SamTower5
      };
      sam[5] = {
         "name":"SAM Lv 5",
         "klass":SamTower5,
         "ground":true,
         "air":true,
         "range":200,
         "speed":0.5,
         "damage":30,
         "damage_text":"11x30",
         "bullet_speed":2,
         "max_targets":3,
         "total_missiles":10,
         "ground_missiles":4,
         "cost":12 + 25 + 55 + 85 + 165,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      sensor[1] = {
         "name":"Sensor Lv 1",
         "klass":SensorTower,
         "damage_display":"None",
         "range_display":"Very Long",
         "speed_display":"Very Slow",
         "effect_display":"Detect Invisible\nStuns at lv 4",
         "ground":true,
         "air":true,
         "portrait_index":9,
         "range":100,
         "speed":0,
         "damage":0,
         "cost":8,
         "upgrade_cost":16,
         "upgrade_to":SensorTower2
      };
      sensor[2] = {
         "name":"Sensor Lv 2",
         "klass":SensorTower2,
         "range":125,
         "speed":0,
         "damage":0,
         "cost":8 + 16,
         "upgrade_cost":26,
         "upgrade_to":SensorTower3
      };
      sensor[3] = {
         "name":"Sensor Lv 3",
         "klass":SensorTower3,
         "range":150,
         "speed":0,
         "damage":0,
         "bullet_speed":5,
         "cost":8 + 16 + 26,
         "upgrade_cost":100,
         "upgrade_to":SensorTower4
      };
      sensor[4] = {
         "name":"Sensor Lv 4",
         "klass":SensorTower4,
         "range":175,
         "speed":0.1,
         "damage":0,
         "damage_text":"Stun 1",
         "stun_length":1.5,
         "stun_targets":1,
         "cost":8 + 16 + 26 + 100,
         "upgrade_cost":100,
         "upgrade_to":SensorTower5
      };
      sensor[5] = {
         "name":"Sensor Lv 5",
         "klass":SensorTower5,
         "range":200,
         "speed":0.1,
         "damage":0,
         "damage_text":"Stun 2",
         "stun_length":2.5,
         "stun_targets":2,
         "cost":8 + 16 + 26 + 100 + 100,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      ice[1] = {
         "name":"Ice Lv 1",
         "klass":IceTower,
         "damage_display":"Very Low",
         "range_display":"Medium",
         "speed_display":"Normal",
         "effect_display":"Slows\nSmall splash",
         "portrait_index":12,
         "ground":true,
         "air":true,
         "range":60,
         "speed":0.5,
         "damage":2,
         "damage_text":"2*",
         "bullet_speed":3,
         "splash_damage":1,
         "splash_range":10,
         "slow":0.3,
         "slow_time":2,
         "slow_rank":1,
         "cost":20,
         "upgrade_cost":25,
         "upgrade_to":IceTower2
      };
      ice[2] = {
         "name":"Ice Lv 2",
         "klass":IceTower2,
         "range":70,
         "speed":0.5,
         "damage":4,
         "damage_text":"4*",
         "bullet_speed":3,
         "splash_damage":2,
         "splash_range":15,
         "slow":0.35,
         "slow_time":2.5,
         "slow_rank":2,
         "cost":20 + 25,
         "upgrade_cost":30,
         "upgrade_to":IceTower3
      };
      ice[3] = {
         "name":"Ice Lv 3",
         "klass":IceTower3,
         "range":80,
         "speed":0.5,
         "damage":6,
         "damage_text":"6*",
         "bullet_speed":3,
         "splash_damage":3,
         "splash_range":20,
         "slow":0.4,
         "slow_time":3,
         "slow_rank":3,
         "cost":25 + 25 + 25,
         "upgrade_cost":40,
         "upgrade_to":IceTower4
      };
      ice[4] = {
         "name":"Ice Lv 4",
         "klass":IceTower4,
         "range":90,
         "speed":0.5,
         "damage":8,
         "damage_text":"8*",
         "bullet_speed":3,
         "splash_damage":1,
         "splash_range":10,
         "slow":0.45,
         "slow_time":3.5,
         "slow_rank":4,
         "cost":25 + 25 + 25 + 40,
         "upgrade_cost":75,
         "upgrade_to":IceTower5
      };
      ice[5] = {
         "name":"Ice Lv 5",
         "klass":IceTower5,
         "range":100,
         "speed":0.5,
         "damage":10,
         "damage_text":"10*",
         "bullet_speed":3,
         "splash_damage":5,
         "splash_range":30,
         "slow":0.55,
         "slow_time":4,
         "slow_rank":5,
         "cost":25 + 25 + 25 + 40 + 75,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      fire[1] = {
         "name":"Flame Lv 1",
         "klass":FireTower,
         "damage_display":"Low",
         "range_display":"Short",
         "speed_display":"Very Fast",
         "effect_display":"Burns\nIgnores armor",
         "ground":true,
         "air":false,
         "portrait_index":15,
         "range":32 + 15,
         "speed":3,
         "damage":5,
         "flame_damage":14,
         "flame_duration":4,
         "cost":75,
         "upgrade_cost":75,
         "upgrade_to":FireTower2
      };
      fire[2] = {
         "name":"Flame Lv 2",
         "klass":FireTower2,
         "range":39 + 15,
         "speed":3,
         "damage":10,
         "flame_damage":25,
         "flame_duration":5,
         "cost":75 + 75,
         "upgrade_cost":75,
         "upgrade_to":FireTower3
      };
      fire[3] = {
         "name":"Flame Lv 3",
         "klass":FireTower3,
         "range":46 + 15,
         "speed":3,
         "damage":15,
         "flame_damage":36,
         "flame_duration":6,
         "cost":75 + 75 + 75,
         "upgrade_cost":90,
         "upgrade_to":FireTower4
      };
      fire[4] = {
         "name":"Flame Lv 4",
         "klass":FireTower4,
         "range":52 + 15,
         "speed":3,
         "damage":22,
         "flame_damage":48,
         "flame_duration":7,
         "cost":75 + 75 + 75 + 90,
         "upgrade_cost":175,
         "upgrade_to":FireTower5
      };
      fire[5] = {
         "name":"Flame Lv 5",
         "klass":FireTower5,
         "range":60 + 15,
         "speed":3,
         "damage":36,
         "flame_damage":70,
         "flame_duration":8,
         "cost":75 + 75 + 75 + 90 + 175,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      rapid[1] = {
         "name":"Minigun Lv 1",
         "klass":RapidTower,
         "damage_display":"Low",
         "range_display":"Medium",
         "speed_display":"Very Fast",
         "effect_display":"None",
         "portrait_index":21,
         "ground":true,
         "air":true,
         "range":75,
         "speed":1.5,
         "damage":6,
         "cost":35,
         "upgrade_cost":68,
         "upgrade_to":RapidTower2
      };
      rapid[2] = {
         "name":"Minigun Lv 2",
         "klass":RapidTower2,
         "range":80,
         "speed":2.5,
         "damage":12,
         "cost":35 + 68,
         "upgrade_cost":108,
         "upgrade_to":RapidTower3
      };
      rapid[3] = {
         "name":"Minigun Lv 3",
         "klass":RapidTower3,
         "range":85,
         "speed":3.5,
         "damage":19,
         "cost":35 + 68 + 108,
         "upgrade_cost":160,
         "upgrade_to":RapidTower4
      };
      rapid[4] = {
         "name":"Minigun Lv 4",
         "klass":RapidTower4,
         "range":90,
         "speed":4.75,
         "damage":27,
         "cost":35 + 68 + 108 + 160,
         "upgrade_cost":210,
         "upgrade_to":RapidTower5
      };
      rapid[5] = {
         "name":"Minigun Lv 5",
         "klass":RapidTower5,
         "range":100,
         "speed":6,
         "damage":36,
         "cost":35 + 68 + 108 + 160 + 210,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      buzzsaw[1] = {
         "name":"Buzzsaw Lv 1",
         "klass":BuzzsawTower,
         "damage_display":"High",
         "range_display":"Long",
         "speed_display":"Slow",
         "effect_display":"Hits multiple\nzombies\nTargets air\nat lv 4",
         "portrait_index":18,
         "ground":true,
         "air":false,
         "range":75,
         "speed":0.5,
         "damage":25,
         "cost":60,
         "upgrade_cost":80,
         "upgrade_to":BuzzsawTower2
      };
      buzzsaw[2] = {
         "name":"Buzzsaw Lv 2",
         "klass":BuzzsawTower2,
         "ground":true,
         "air":false,
         "range":85,
         "speed":0.45,
         "damage":60,
         "cost":60 + 80,
         "upgrade_cost":120,
         "upgrade_to":BuzzsawTower3
      };
      buzzsaw[3] = {
         "name":"Buzzsaw Lv 3",
         "klass":BuzzsawTower3,
         "ground":true,
         "air":false,
         "range":95,
         "speed":0.4,
         "damage":130,
         "cost":60 + 80 + 120,
         "upgrade_cost":165,
         "upgrade_to":BuzzsawTower4
      };
      buzzsaw[4] = {
         "name":"Buzzsaw Lv 4",
         "klass":BuzzsawTower4,
         "ground":true,
         "air":true,
         "range":105,
         "speed":0.35,
         "damage":220,
         "cost":60 + 80 + 120 + 165,
         "upgrade_cost":200,
         "upgrade_to":BuzzsawTower5
      };
      buzzsaw[5] = {
         "name":"Buzzsaw Lv 5",
         "klass":BuzzsawTower5,
         "ground":true,
         "air":true,
         "range":115,
         "speed":0.3,
         "damage":410,
         "cost":60 + 80 + 120 + 165 + 200,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      laser[1] = {
         "name":"Laser Lv 1",
         "klass":LaserTower,
         "damage_display":"Extreme",
         "range_display":"Very Long",
         "speed_display":"Very Slow",
         "effect_display":"None",
         "portrait_index":24,
         "ground":true,
         "air":true,
         "range":100,
         "speed":0.25,
         "damage":100,
         "cost":100,
         "upgrade_cost":150,
         "upgrade_to":LaserTower2
      };
      laser[2] = {
         "name":"Laser Lv 2",
         "klass":LaserTower2,
         "range":125,
         "speed":0.25,
         "damage":250,
         "cost":100 + 150,
         "upgrade_cost":200,
         "upgrade_to":LaserTower3
      };
      laser[3] = {
         "name":"Laser Lv 3",
         "klass":LaserTower3,
         "range":150,
         "speed":0.25,
         "damage":450,
         "cost":100 + 150 + 200,
         "upgrade_cost":250,
         "upgrade_to":LaserTower4
      };
      laser[4] = {
         "name":"Laser Lv 4",
         "klass":LaserTower4,
         "range":175,
         "speed":0.3,
         "damage":700,
         "cost":100 + 150 + 200 + 250,
         "upgrade_cost":300,
         "upgrade_to":LaserTower5
      };
      laser[5] = {
         "name":"Laser Lv 5",
         "klass":LaserTower5,
         "range":200,
         "speed":0.35,
         "damage":1000,
         "cost":100 + 150 + 200 + 250 + 300,
         "upgrade_cost":0,
         "upgrade_to":null
      };
      
      public function Towers()
      {
         super();
      }
      
      public static function update() : void
      {
         sentry[1].name = Localizer.Instance.tower_sentry + " 1";
         sentry[2].name = Localizer.Instance.tower_sentry + " 2";
         sentry[3].name = Localizer.Instance.tower_sentry + " 3";
         sentry[4].name = Localizer.Instance.tower_sentry + " 4";
         sentry[5].name = Localizer.Instance.tower_sentry + " 5";
         sentry[1].damage_display = Localizer.Instance.tower_info_average;
         sentry[1].range_display = Localizer.Instance.tower_info_long;
         sentry[1].speed_display = Localizer.Instance.tower_info_normal;
         sentry[1].effect_display = Localizer.Instance.tower_info_none;
         bomb[1].name = Localizer.Instance.tower_cannon + " 1";
         bomb[2].name = Localizer.Instance.tower_cannon + " 2";
         bomb[3].name = Localizer.Instance.tower_cannon + " 3";
         bomb[4].name = Localizer.Instance.tower_cannon + " 4";
         bomb[5].name = Localizer.Instance.tower_cannon + " 5";
         bomb[1].damage_display = Localizer.Instance.tower_info_average;
         bomb[1].range_display = Localizer.Instance.tower_info_short;
         bomb[1].speed_display = Localizer.Instance.tower_info_normal;
         bomb[1].effect_display = Localizer.Instance.tower_info_large_splash;
         sam[1].name = Localizer.Instance.tower_sam + " 1";
         sam[2].name = Localizer.Instance.tower_sam + " 2";
         sam[3].name = Localizer.Instance.tower_sam + " 3";
         sam[4].name = Localizer.Instance.tower_sam + " 4";
         sam[5].name = Localizer.Instance.tower_sam + " 5";
         sam[1].damage_display = Localizer.Instance.tower_info_low;
         sam[1].range_display = Localizer.Instance.tower_info_very_long;
         sam[1].speed_display = Localizer.Instance.tower_info_normal;
         sam[1].effect_display = Localizer.Instance.tower_info_target_ground + "\n" + Localizer.Instance.tower_info_super_missile;
         sensor[1].name = Localizer.Instance.tower_sensor + " 1";
         sensor[2].name = Localizer.Instance.tower_sensor + " 2";
         sensor[3].name = Localizer.Instance.tower_sensor + " 3";
         sensor[4].name = Localizer.Instance.tower_sensor + " 4";
         sensor[5].name = Localizer.Instance.tower_sensor + " 5";
         sensor[1].damage_display = Localizer.Instance.tower_info_none;
         sensor[1].range_display = Localizer.Instance.tower_info_very_long;
         sensor[1].speed_display = Localizer.Instance.tower_info_very_slow;
         sensor[1].effect_display = Localizer.Instance.tower_info_detect_invisible + "\n" + Localizer.Instance.tower_info_stuns;
         ice[1].name = Localizer.Instance.tower_ice + " 1";
         ice[2].name = Localizer.Instance.tower_ice + " 2";
         ice[3].name = Localizer.Instance.tower_ice + " 3";
         ice[4].name = Localizer.Instance.tower_ice + " 4";
         ice[5].name = Localizer.Instance.tower_ice + " 5";
         ice[1].damage_display = Localizer.Instance.tower_info_very_low;
         ice[1].range_display = Localizer.Instance.tower_info_medium;
         ice[1].speed_display = Localizer.Instance.tower_info_normal;
         ice[1].effect_display = Localizer.Instance.tower_info_slows + "\n" + Localizer.Instance.tower_info_small_splash;
         rapid[1].name = Localizer.Instance.tower_minigun + " 1";
         rapid[2].name = Localizer.Instance.tower_minigun + " 2";
         rapid[3].name = Localizer.Instance.tower_minigun + " 3";
         rapid[4].name = Localizer.Instance.tower_minigun + " 4";
         rapid[5].name = Localizer.Instance.tower_minigun + " 5";
         rapid[1].damage_display = Localizer.Instance.tower_info_low;
         rapid[1].range_display = Localizer.Instance.tower_info_medium;
         rapid[1].speed_display = Localizer.Instance.tower_info_very_fast;
         rapid[1].effect_display = Localizer.Instance.tower_info_none;
         buzzsaw[1].name = Localizer.Instance.tower_buzzsaw + " 1";
         buzzsaw[2].name = Localizer.Instance.tower_buzzsaw + " 2";
         buzzsaw[3].name = Localizer.Instance.tower_buzzsaw + " 3";
         buzzsaw[4].name = Localizer.Instance.tower_buzzsaw + " 4";
         buzzsaw[5].name = Localizer.Instance.tower_buzzsaw + " 5";
         buzzsaw[1].damage_display = Localizer.Instance.tower_info_high;
         buzzsaw[1].range_display = Localizer.Instance.tower_info_long;
         buzzsaw[1].speed_display = Localizer.Instance.tower_info_slow;
         buzzsaw[1].effect_display = Localizer.Instance.tower_info_hits_multiple + "\n" + Localizer.Instance.tower_info_target_air;
         fire[1].name = Localizer.Instance.tower_fire + " 1";
         fire[2].name = Localizer.Instance.tower_fire + " 2";
         fire[3].name = Localizer.Instance.tower_fire + " 3";
         fire[4].name = Localizer.Instance.tower_fire + " 4";
         fire[5].name = Localizer.Instance.tower_fire + " 5";
         fire[1].damage_display = Localizer.Instance.tower_info_low;
         fire[1].range_display = Localizer.Instance.tower_info_short;
         fire[1].speed_display = Localizer.Instance.tower_info_very_fast;
         fire[1].effect_display = Localizer.Instance.tower_info_burns + "\n" + Localizer.Instance.tower_info_ignores_armor;
         laser[1].name = Localizer.Instance.tower_laser + " 1";
         laser[2].name = Localizer.Instance.tower_laser + " 2";
         laser[3].name = Localizer.Instance.tower_laser + " 3";
         laser[4].name = Localizer.Instance.tower_laser + " 4";
         laser[5].name = Localizer.Instance.tower_laser + " 5";
         laser[1].damage_display = Localizer.Instance.tower_info_extreme;
         laser[1].range_display = Localizer.Instance.tower_info_very_long;
         laser[1].speed_display = Localizer.Instance.tower_info_very_slow;
         laser[1].effect_display = Localizer.Instance.tower_info_none;
      }
   }
}

