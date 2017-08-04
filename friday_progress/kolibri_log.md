

Scenario

  - Import 2 channels from USB stick
  - Delete first channel works (db file gets removed)
  - Delete second channel is fails (file is locked --- presumably because of attachment issues

Detailed walkthough below



## Initial boot


    INFO 2017-08-04 10:48:13,033 cli Kolibri running for the first time.
    INFO 2017-08-04 10:48:13,033 cli We don't yet use pre-migrated database seeds, so you're going to have to wait a bit while we create a blank database...
    INFO 2017-08-04 10:48:15,753 cli Automatically enabling applications.
    INFO 2017-08-04 10:48:15,753 cli Running update routines for new version...
    INFO 2017-08-04 10:48:20,408 cli Running 'kolibri start' as daemon (system service)
    INFO 2017-08-04 10:48:20,408 cli Going to daemon mode, logging to C:\Users\IEUser\.kolibri\server.log
    INFO 2017-08-04 10:48:20,408 annotation In update_channel_metadata_cache <<<<<<    <<<<<<    <<<<<<   <<<<<<    <<<<<<


## Import from USB


### Load metadata from USB stick

    INFO 2017-08-04 10:49:04,272 content_db_router    __enter__ using_content_database alias=F:\KOLIBRI_DATA\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3 previous_alias=None
    INFO 2017-08-04 10:49:04,272 content_db_router SETTTING set_active_content_database to alias=F:\KOLIBRI_DATA\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    INFO 2017-08-04 10:49:04,273 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,276 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = F:\KOLIBRI_DATA\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    INFO 2017-08-04 10:49:04,276 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = F:\KOLIBRI_DATA\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    INFO 2017-08-04 10:49:04,276 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = F:\KOLIBRI_DATA\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    INFO 2017-08-04 10:49:04,276 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = F:\KOLIBRI_DATA\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    INFO 2017-08-04 10:49:04,279 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,279 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:04,279 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,279 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:04,280 content_db_router    __exit__ using_content_database putting back self.previous_alias=None



    INFO 2017-08-04 10:49:04,282 content_db_router    __enter__ using_content_database alias=F:\KOLIBRI_DATA\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3 previous_alias=None
    INFO 2017-08-04 10:49:04,282 content_db_router SETTTING set_active_content_database to alias=F:\KOLIBRI_DATA\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3
    INFO 2017-08-04 10:49:04,282 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,285 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = F:\KOLIBRI_DATA\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3
    INFO 2017-08-04 10:49:04,285 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = F:\KOLIBRI_DATA\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3
    INFO 2017-08-04 10:49:04,286 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = F:\KOLIBRI_DATA\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3
    INFO 2017-08-04 10:49:04,286 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = F:\KOLIBRI_DATA\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3
    INFO 2017-08-04 10:49:04,286 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,286 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:04,288 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,288 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:04,289 content_db_router    __exit__ using_content_database putting back self.previous_alias=None



### FIRST IMPORTCHANNEL

    INFO 2017-08-04 10:49:04,305 importchannel Copying in data for channel id 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,315 annotation In update_channel_metadata_cache <<<<<<    <<<<<<    <<<<<<   <<<<<<    <<<<<<
    INFO 2017-08-04 10:49:04,319 content_db_router    __enter__ using_content_database alias=8ca4d9403d4d5d938b4aa498a24c8177 previous_alias=None
    INFO 2017-08-04 10:49:04,319 content_db_router SETTTING set_active_content_database to alias=8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,321 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,322 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,323 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,323 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,325 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,325 content_db_router    __exit__ using_content_database putting back self.previous_alias=None
    INFO 2017-08-04 10:49:04,325 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:04,365 content_db_router    __enter__ using_content_database alias=8ca4d9403d4d5d938b4aa498a24c8177 previous_alias=None
    INFO 2017-08-04 10:49:04,365 content_db_router SETTTING set_active_content_database to alias=8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,365 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:04,368 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:04,368 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:05,015 api job is truthy
    INFO 2017-08-04 10:49:05,015 api {'status': 'RUNNING', 'exception': 'None', 'traceback': '', 'percentage': 1.0, 'type': 'remoteimport', 'id': '4d68ebb5aa604a02981fbfb61c7544b4'}
    INFO 2017-08-04 10:49:05,015 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:06,012 api job is truthy
    INFO 2017-08-04 10:49:06,012 api {'status': 'RUNNING', 'exception': 'None', 'traceback': '', 'percentage': 0.2801926919864784, 'type': 'remoteimport', 'id': '4d68ebb5aa604a02981fbfb61c7544b4'}
    INFO 2017-08-04 10:49:06,012 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:07,013 api job is truthy
    INFO 2017-08-04 10:49:07,015 api {'status': 'RUNNING', 'exception': 'None', 'traceback': '', 'percentage': 0.4086404599334025, 'type': 'remoteimport', 'id': '4d68ebb5aa604a02981fbfb61c7544b4'}
    INFO 2017-08-04 10:49:07,016 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:08,016 api job is truthy
    INFO 2017-08-04 10:49:08,016 api {'status': 'RUNNING', 'exception': 'None', 'traceback': '', 'percentage': 0.5125112502320176, 'type': 'remoteimport', 'id': '4d68ebb5aa604a02981fbfb61c7544b4'}
    INFO 2017-08-04 10:49:08,016 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:09,013 api job is truthy
    INFO 2017-08-04 10:49:09,013 api {'status': 'RUNNING', 'exception': 'None', 'traceback': '', 'percentage': 0.8717981148333527, 'type': 'remoteimport', 'id': '4d68ebb5aa604a02981fbfb61c7544b4'}
    INFO 2017-08-04 10:49:09,013 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:09,309 content_db_router    __exit__ using_content_database putting back self.previous_alias=None
    INFO 2017-08-04 10:49:09,309 content_db_router SETTTING set_active_content_database to alias=None


### SECOND IMPORTCHANNEL


    INFO 2017-08-04 10:49:09,312 importchannel Copying in data for channel id d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,321 annotation In update_channel_metadata_cache <<<<<<    <<<<<<    <<<<<<   <<<<<<    <<<<<<
    INFO 2017-08-04 10:49:09,325 content_db_router    __enter__ using_content_database alias=8ca4d9403d4d5d938b4aa498a24c8177 previous_alias=None
    INFO 2017-08-04 10:49:09,325 content_db_router SETTTING set_active_content_database to alias=8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:09,325 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:09,325 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:09,325 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:09,325 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:09,326 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:09,328 content_db_router    __exit__ using_content_database putting back self.previous_alias=None
    INFO 2017-08-04 10:49:09,328 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:09,338 content_db_router    __enter__ using_content_database alias=d1ad8e2e4dfa5efdbe8df50cc38ab86e previous_alias=None
    INFO 2017-08-04 10:49:09,338 content_db_router SETTTING set_active_content_database to alias=d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,339 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:09,348 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,348 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,348 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,348 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,351 content_db_router    __exit__ using_content_database putting back self.previous_alias=None
    INFO 2017-08-04 10:49:09,351 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:09,375 content_db_router    __enter__ using_content_database alias=d1ad8e2e4dfa5efdbe8df50cc38ab86e previous_alias=None
    INFO 2017-08-04 10:49:09,377 content_db_router SETTTING set_active_content_database to alias=d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,377 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:09,380 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,381 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:09,964 content_db_router    __exit__ using_content_database putting back self.previous_alias=None




## CALLS MADE BEFORE DELETE CAN HAPPEN

    INFO 2017-08-04 10:49:25,016 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:26,015 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:26,049 content_db_router SETTTING set_active_content_database to alias=8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:26,059 content_db_router SETTTING set_active_content_database to alias=d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:26,061 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected

    INFO 2017-08-04 10:49:26,065 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:26,065 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = 8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:26,065 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = 8ca4d9403d4d5d938b4aa498a24c8177

    INFO 2017-08-04 10:49:26,066 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:26,066 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:26,066 content_db_router SUUCESSSFULLY ATTACHED C:\Users\IEUser\.kolibri\db.sqlite3  -------->  db w alias = d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:26,069 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:26,069 models In ChannelMetadata objects = ContentQuerySet.__init__ with   using = d1ad8e2e4dfa5efdbe8df50cc38ab86e

    INFO 2017-08-04 10:49:26,075 content_db_router In _attach_default_database UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU unexpected
    INFO 2017-08-04 10:49:26,076 content_db_router Hit OperationalError in _attach_default_database database defaultdb is already in use
    INFO 2017-08-04 10:49:26,076 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:30,013 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:31,009 content_db_router SETTTING set_active_content_database to alias=None



## FIRST DELETE POST SUCCEEDS

    INFO 2017-08-04 10:49:31,042 api In ChannelMetadataCacheViewSet.destroy pk=8ca4d9403d4d5d938b4aa498a24c8177
    INFO 2017-08-04 10:49:31,048 api VERY HOPEFUL ABOUT THIS ONE
    INFO 2017-08-04 10:49:31,049 content_db_router In _detach_default_database FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF fix? :fingers crossed:
    INFO 2017-08-04 10:49:31,049 content_db_router Hit OperationalError in _detach_default_database no such database: defaultdb
    INFO 2017-08-04 10:49:31,053 api Taking a break for 2 secs...
    INFO 2017-08-04 10:49:32,012 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:33,013 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:33,055 api dbpath=C:\Users\IEUser\.kolibri\content\databases\8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    INFO 2017-08-04 10:49:33,055 api DB file exists before remove
    INFO 2017-08-04 10:49:33,056 api delete_content_db_file returned True
    INFO 2017-08-04 10:49:33,058 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:46,010 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:47,012 content_db_router SETTTING set_active_content_database to alias=None



## SECOND DELETE POST FAILS

    INFO 2017-08-04 10:49:47,466 api In ChannelMetadataCacheViewSet.destroy pk=d1ad8e2e4dfa5efdbe8df50cc38ab86e
    INFO 2017-08-04 10:49:47,469 api VERY HOPEFUL ABOUT THIS ONE
    INFO 2017-08-04 10:49:47,470 content_db_router In _detach_default_database FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF fix? :fingers crossed:
    INFO 2017-08-04 10:49:47,470 content_db_router Hit OperationalError in _detach_default_database no such database: defaultdb
    INFO 2017-08-04 10:49:47,477 api Taking a break for 2 secs...
    INFO 2017-08-04 10:49:48,013 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:49,012 content_db_router SETTTING set_active_content_database to alias=None
    INFO 2017-08-04 10:49:49,479 api dbpath=C:\Users\IEUser\.kolibri\content\databases\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3
    INFO 2017-08-04 10:49:49,480 api DB file exists before remove
    INFO 2017-08-04 10:49:49,480 api FRIDAY  EEEEEEE   EEEEEEE   EEEEEEE   EEEEEEE  OSError occured [Error 32] The process cannot access the file because it is being used by another process: u'C:\\Users\\IEUser\\.kolibri\\content\\databases\\d1ad8e2e4dfa5efdbe8df50cc38ab86e.sqlite3'



