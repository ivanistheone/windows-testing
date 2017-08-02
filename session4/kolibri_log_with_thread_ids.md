
# Thread questions



Test scenario

    - Empty Kolibri
    - Import from USB small test channel 8ca4d9403d4d5d938b4aa498a24c8177 for testing
    - Channel import completes fine
    - Try to unmount USB stick (not allowed bcs locked)


The code is heavily instrumented for logging, in particular we see the thread_ids
  - 4370767872 = django
  - 4377579520 worker thread that does FileTransfer? Or a reporting thread?
  - other bbq related threads 4357885952 + 4362092544 ?

**QUESTION:**
  - Is it normal that notifications about JOB_COMPLETE happens after django thinks the task is finished? (see logs below)
  - Who is supposed to check these status updates?
  - Are the they for UI-only purpose or part of job management?



## Django side



Before actual IMPORT call happens we see these

    INFO:kolibri.content.utils.channels:ZZZZ  In get_mounted_drives_with_channel_DEBUG:kolibri.core.discovery.utils.filesystem.posix:Skipping blacklisted drive '/dev'
    INFO:kolibri.content.utils.channels:ZZZZ In get_channels_for_data_folder
    INFO:kolibri.content.utils.channels:ZZZZZ In enumerate_content_database_file_paths
    INFO:kolibri.content.utils.channels:ZZZZZ In get_channel_ids_for_content_database_dir
    INFO:kolibri.content.utils.channels:In using_content_database
    INFO:kolibri.content.utils.channels:ZZZZ In get_channels_for_data_folder
    INFO:kolibri.content.utils.channels:ZZZZZ In enumerate_content_database_file_paths
    INFO:kolibri.content.utils.channels:ZZZZZ In get_channel_ids_for_content_database_dir


**THE ABOVE STEPS ARE PROBABLY THE CAUSE OF THE LOCKED DB**: need to figure out how to avoid lazy loading... or generally close connection to DB.


The import channel api call starts here:

    2017-08-02 16:18:03,418(4370767872) INFO kolibri.tasks.api:
    2017-08-02 16:18:03,419(4370767872) INFO kolibri.tasks.api: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    2017-08-02 16:18:03,419(4370767872) INFO kolibri.tasks.api: in _localimport >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> update_progress = <functools.partial object at 0x103317998>
    2017-08-02 16:18:03,441(4370767872) INFO kolibri.content.management.commands.importchannel: Copying in data for channel id 8ca4d9403d4d5d938b4aa498a24c8177
    2017-08-02 16:18:03,442(4370767872) INFO kolibri.content.management.commands.importchannel: in _transfer. method = <copy> channel_id = 8ca4d9403d4d5d938b4aa498a24c8177
    2017-08-02 16:18:03,442(4370767872) INFO kolibri.content.utils.transfer: In Transfer.__init__ with {'started': False, 'closed': False, 'finalized': False, 'dest': u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', 'completed': False, 'source': '/Volumes/USB DISK/KOLIBRI_DATA/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', 'timeout': 20, 'block_size': 2097152, 'dest_tmp': u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3.transfer'}
    2017-08-02 16:18:03,443(4370767872) DEBUG root: Not creating directory '/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases' as it already exists.
    DEBUG    Destination: /Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    2017-08-02 16:18:03,443(4370767872) DEBUG kolibri.content.management.commands.importchannel: Destination: /Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3
    2017-08-02 16:18:03,443(4370767872) INFO kolibri.content.management.commands.importchannel: src path is /Volumes/USB DISK/KOLIBRI_DATA/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3



    2017-08-02 16:18:03,444(4370767872) INFO kolibri.content.management.commands.importchannel: before filetransfer={'started': False, 'closed': False, 'finalized': False, 'dest': u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', 'completed': False, 'source': '/Volumes/USB DISK/KOLIBRI_DATA/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', 'dest_file_obj': <open file u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3.transfer', mode 'wb' at 0x1033ab390>, 'timeout': 20, 'dest_exists': False, 'block_size': 2097152, 'dest_tmp': u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3.transfer'}


    2017-08-02 16:18:03,444(4370767872) INFO kolibri.content.utils.transfer: in Transfer.__enter__
    2017-08-02 16:18:03,444(4370767872) INFO kolibri.content.utils.transfer: in FileCopy.start  _____________
    2017-08-02 16:18:03,444(4370767872) INFO kolibri.content.management.commands.importchannel: in filetransfer context...
    2017-08-02 16:18:03,445(4370767872) INFO kolibri.tasks.management.commands.base: In AsyncCommand.start_progress. total = 240640
      0%|                                                                                                                                                     | 0/240640 [00:00<?, ?it/s]INFO     in FileCopy.__iter__
    2017-08-02 16:18:03,445(4370767872) INFO kolibri.content.utils.transfer: in FileCopy.__iter__
    2017-08-02 16:18:03,445(4370767872) INFO kolibri.content.utils.transfer: in FileCopy._read_block_iterator  ioioio
    2017-08-02 16:18:03,446(4370767872) INFO kolibri.content.management.commands.importchannel: processing chunk:::
    2017-08-02 16:18:03,446(4370767872) INFO kolibri.tasks.management.commands.base: In ProgressTracker.update_progress240640{'channel_id': '8ca4d9403d4d5d938b4aa498a24c8177'}None
    2017-08-02 16:18:03,446(4370767872) INFO kolibri.tasks.management.commands.base: in get_progress Progress(progress_fraction=1.0, message={'channel_id': '8ca4d9403d4d5d938b4aa498a24c8177'}, extra_data=None, level=0)
    2017-08-02 16:18:03,447(4370767872) INFO kolibri.tasks.management.commands.base: In AsyncCommand._update_all_progress. progress = Progress(progress_fraction=1.0, message={'channel_id': '8ca4d9403d4d5d938b4aa498a24c8177'}, extra_data=None, level=0)
    2017-08-02 16:18:03,447(4370767872) INFO kolibri.tasks.management.commands.base: in get_progress Progress(progress_fraction=1.0, message={'channel_id': '8ca4d9403d4d5d938b4aa498a24c8177'}, extra_data=None, level=0)
    2017-08-02 16:18:03,447(4370767872) DEBUG barbequeue.messaging.backends.inmem: SEND MAILBOX: 56cc2ea4a92149938075c21dc2369782 MSG: _Message(type='JOB_UPDATED', message={'progress': 1.0, 'job_id': '56a630ebba2f4d28acfdff92f31d77b6', 'total_progress': 1.0, 'stage': ''})
    2017-08-02 16:18:03,447(4370767872) INFO kolibri.content.utils.transfer: in FileCopy._read_block_iterator  ioioio
    2017-08-02 16:18:03,447(4370767872) INFO kolibri.content.utils.transfer: in FileCopy.close  _____________
    2017-08-02 16:18:03,447(4370767872) INFO kolibri.content.utils.transfer: in Transfer.close  zozozo
    2017-08-02 16:18:03,449(4370767872) INFO kolibri.content.utils.transfer: in Transfer.finalize  zozozo
    100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 240640/240640 [00:00<00:00, 53369147.34it/s]
    2017-08-02 16:18:03,450(4370767872) INFO kolibri.content.utils.transfer: in FileCopy.__exit__
    2017-08-02 16:18:03,450(4370767872) INFO kolibri.content.utils.transfer: in FileCopy.close  _____________
    2017-08-02 16:18:03,450(4370767872) INFO kolibri.content.utils.transfer: in Transfer.close  zozozo
    2017-08-02 16:18:03,450(4370767872) INFO kolibri.content.utils.transfer: in Transfer.__exit__
    2017-08-02 16:18:03,451(4370767872) INFO kolibri.content.management.commands.importchannel: should have exited filetransfer context by now...


    2017-08-02 16:18:03,451(4370767872) INFO kolibri.content.management.commands.importchannel: after filetransfer={'started': True, 'source_file_obj': <closed file '/Volumes/USB DISK/KOLIBRI_DATA/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', mode 'rb' at 0x1033ab420>, 'closed': True, '_content_iterator': <generator object _read_block_iterator at 0x103343410>, 'finalized': True, 'dest':
    u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', 'completed': True, 'total_size': 240640, 'source': '/Volumes/USB DISK/KOLIBRI_DATA/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3', 'dest_file_obj': <closed file u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3.transfer', mode 'wb' at 0x1033ab390>, 'timeout': 20, 'dest_exists': False, 'block_size': 2097152, 'dest_tmp': u'/Users/ivan/Projects/FLECode/new_kolibri_home/content/databases/8ca4d9403d4d5d938b4aa498a24c8177.sqlite3.transfer'}


    2017-08-02 16:18:03,452(4370767872) INFO kolibri.tasks.api: >> finished calling importchannel
    2017-08-02 16:18:03,452(4370767872) DEBUG barbequeue.messaging.backends.inmem: SEND MAILBOX: 56cc2ea4a92149938075c21dc2369782 MSG: _Message(type='JOB_COMPLETED', message={'job_id': '56a630ebba2f4d28acfdff92f31d77b6', 'result': None})


DJANGO THINKS JOB'S COMPLETED!




## Worker side


BUT WAIT NOW THE JOB STARTS, EXECUTING IN THREAD  4377579520


    2017-08-02 16:18:03,817(4377579520) INFO kolibri.tasks.api: in _job_to_response ########
    2017-08-02 16:18:03,817(4377579520) INFO kolibri.tasks.api: job is truthy
    2017-08-02 16:18:03,817(4377579520) INFO kolibri.tasks.api: {'status': 'QUEUED', 'exception': 'None', 'traceback': '', 'percentage': 0, 'type': 'remoteimport', 'id': '56a630ebba2f4d28acfdff92f31d77b6'}
    2017-08-02 16:18:04,813(4377579520) INFO kolibri.tasks.api: in _job_to_response ########
    2017-08-02 16:18:04,813(4377579520) INFO kolibri.tasks.api: job is truthy
    2017-08-02 16:18:04,814(4377579520) INFO kolibri.tasks.api: {'status': 'COMPLETED', 'exception': 'None', 'traceback': '', 'percentage': 1.0, 'type': 'remoteimport', 'id': '56a630ebba2f4d28acfdff92f31d77b6'}
    2017-08-02 16:18:05,812(4377579520) INFO kolibri.tasks.api: in _job_to_response ########
    2017-08-02 16:18:05,813(4377579520) INFO kolibri.tasks.api: job is truthy
    2017-08-02 16:18:05,813(4377579520) INFO kolibri.tasks.api: {'status': 'COMPLETED', 'exception': 'None', 'traceback': '', 'percentage': 1.0, 'type': 'remoteimport', 'id': '56a630ebba2f4d28acfdff92f31d77b6'}







##  Normal barbeque polling operation resumes ?


    [02/Aug/2017 16:18:05] "GET /api/tasks/?1501705085797=1501705085797 HTTP/1.1" 200 137
    2017-08-02 16:18:05,837(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:06,369(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:06,748(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    [02/Aug/2017 16:18:06] "GET /api/content/?1501705086718=1501705086718 HTTP/1.1" 200 2
    [02/Aug/2017 16:18:06] "POST /api/tasks/cleartask/?1501705086712=1501705086712 HTTP/1.1" 200 2
    [02/Aug/2017 16:18:06] "GET /api/tasks/?1501705086797=1501705086797 HTTP/1.1" 200 2
    2017-08-02 16:18:07,077(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:07,658(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:07,787(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:07] "GET /api/tasks/?1501705087801=1501705087801 HTTP/1.1" 200 2
    2017-08-02 16:18:08,496(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:08,562(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    [02/Aug/2017 16:18:08] "GET /api/tasks/?1501705088797=1501705088797 HTTP/1.1" 200 2
    2017-08-02 16:18:09,202(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:09,473(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    [02/Aug/2017 16:18:09] "GET /api/tasks/?1501705089801=1501705089801 HTTP/1.1" 200 2
    2017-08-02 16:18:09,907(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:10,382(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:10,617(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:10] "GET /api/tasks/?1501705090801=1501705090801 HTTP/1.1" 200 2
    2017-08-02 16:18:11,290(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:11,325(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:11] "GET /api/tasks/?1501705091798=1501705091798 HTTP/1.1" 200 2
    2017-08-02 16:18:12,035(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:12,197(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:12,743(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:12] "GET /api/tasks/?1501705092798=1501705092798 HTTP/1.1" 200 2
    2017-08-02 16:18:13,104(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:13,455(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:13] "GET /api/tasks/?1501705093797=1501705093797 HTTP/1.1" 200 2
    2017-08-02 16:18:14,010(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:14,165(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:14] "GET /api/tasks/?1501705094801=1501705094801 HTTP/1.1" 200 2
    2017-08-02 16:18:14,873(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:14,923(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:15,584(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:15] "GET /api/tasks/?1501705095801=1501705095801 HTTP/1.1" 200 2
    2017-08-02 16:18:15,824(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:16,295(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:16,730(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    [02/Aug/2017 16:18:16] "GET /api/tasks/?1501705096799=1501705096799 HTTP/1.1" 200 2
    2017-08-02 16:18:17,004(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:17,634(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:17,707(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:17] "GET /api/tasks/?1501705097796=1501705097796 HTTP/1.1" 200 2
    2017-08-02 16:18:18,416(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:18,544(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    [02/Aug/2017 16:18:18] "GET /api/tasks/?1501705098801=1501705098801 HTTP/1.1" 200 2
    2017-08-02 16:18:19,119(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:19,450(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    [02/Aug/2017 16:18:19] "GET /api/tasks/?1501705099798=1501705099798 HTTP/1.1" 200 2
    2017-08-02 16:18:19,826(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:20,358(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.
    2017-08-02 16:18:20,536(4362092544) DEBUG root: No job to schedule right now.
    [02/Aug/2017 16:18:20] "GET /api/tasks/?1501705100801=1501705100801 HTTP/1.1" 200 2
    2017-08-02 16:18:21,246(4362092544) DEBUG root: No job to schedule right now.
    2017-08-02 16:18:21,274(4357885952) DEBUG barbequeue.worker.backends.base: Worker message queue currently empty.

