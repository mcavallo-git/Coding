REM fork from https://gist.github.com/Nt-gm79sp/1f8ea2c2869b988e88b4fbc183731693
REM   on [ 20190104-135820-0500 ]

@ECHO ON
REM checked for Windows 10
REM fork from https://gist.github.com/theultramage/cbdfdbb733d4a5b7d2669a6255b4b94b
REM you may want full list https://gist.github.com/raspi/203aef3694e34fefebf772c78c37ec2c

REM Diable Hibernation
powercfg.exe /hibernate off

REM Enable Hibernation
REM powercfg.exe /hibernate on

REM SET attrib=+ATTRIB_HIDE
    SET attrib=-ATTRIB_HIDE

REM Hard disk burst ignore time
REM powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 80e3c60e-bb94-4ad8-bbe0-0d3195efc663 %attrib%
REM AHCI Link Power Management - HIPM/DIPM
powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 0b2d69d7-a2a1-449c-9680-f91c70521c60 %attrib%
REM AHCI Link Power Management - Adaptive
powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 dab60367-53fe-4fbc-825e-521d069d2456 %attrib%

REM NVMe Idle Timeout
REM powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 d639518a-e56d-4345-8af2-b9f32fb26109 %attrib%
REM NVMe Power State Transition Latency Tolerance
REM powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 fc95af4d-40e7-4b6d-835a-56d131dbc80e %attrib%

REM Sleep transition settings
REM Allow Away Mode Policy
powercfg -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 25dfa149-5dd1-4736-b5ab-e8a37b5b8187 %attrib%
REM System unattended sleep timeout
powercfg -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 %attrib%
REM Allow System Required Policy
powercfg -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 A4B195F5-8225-47D8-8012-9D41369786E2 %attrib%
REM Allow Standby States
powercfg -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 abfc2519-3608-4c2a-94ea-171b0ed546ab %attrib%
REM Allow sleep with remote opens
powercfg -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 d4c1d4c8-d5cc-43d3-b83e-fc51215cb04d %attrib%
REM System FastS4 Support
powercfg -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 94AC6D29-73CE-41A6-809F-6363BA21B47E %attrib%

REM Device idle policy
REM NOTE: shows in first node of settings tree if unhidden
powercfg -attributes 4faab71a-92e5-4726-b531-224559672d19 %attrib%

REM Processor power settings
REM Processor performance boost policy
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 45bcc044-d885-43e2-8605-ee0ec6e96b59 %attrib%
REM Processor performance increase policy
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 %attrib%
REM Processor performance increase threshold
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 06cadf0e-64ed-448a-8927-ce7bf90eb35d %attrib%
REM Processor performance increase threshold for Processor Power Efficiency Class 1
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 06cadf0e-64ed-448a-8927-ce7bf90eb35e %attrib%
REM REM Processor performance core parking min cores
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 %attrib%
REM REM Processor performance core parking min cores for Processor Power Efficiency Class 1
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318584 %attrib%
REM REM Processor performance decrease threshold
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 12a0ab44-fe28-4fa9-b3bd-4b64f44960a6 %attrib%
REM REM Processor performance core parking increase time
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 2ddd5a84-5a71-437e-912a-db0b8c788732 %attrib%
REM REM Allow Throttle States
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb %attrib%
REM REM Processor performance decrease policy
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 %attrib%
REM REM Processor performance core parking parked performance state
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 447235c7-6a8d-4cc0-8e24-9eaf70b96e2b %attrib%
REM REM Processor idle demote threshold
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4b92d758-5a24-4851-a470-815d78aee119 %attrib%
REM REM Processor performance core parking distribution threshold
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4bdaf4e9-d103-46d7-a5f0-6280121616ef %attrib%
REM REM Processor performance time check interval
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 %attrib%
REM REM Processor duty cycling
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4e4450b3-6179-4e91-b8f1-5bb9938f81a1 %attrib%
REM REM Processor idle disable
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad %attrib%
REM REM Processor idle threshold scaling
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 6c2993b0-8f48-481f-bcc6-00dd2742aa06 %attrib%
REM REM Processor performance core parking decrease policy
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 71021b41-c749-4d21-be74-a00f335d582b %attrib%
REM Maximum processor frequency
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 75b0ae3f-bce0-45a7-8c89-c9611c25e100 %attrib%
REM REM Processor idle promote threshold
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 7b224883-b3cc-4d79-819f-8374152cbe7c %attrib%
REM REM Processor performance history count
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 7d24baa7-0b84-480f-840c-1b0743c00f5f %attrib%
REM REM Processor performance core parking over utilization threshold
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 %attrib%
REM REM Processor performance increase time
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 984cf492-3bed-4488-a8f9-4286c97bf5aa %attrib%
REM REM Processor idle time check
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 c4581c31-89ab-4597-8e2b-9c9cab440e6b %attrib%
REM REM Processor performance core parking increase policy
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 c7be0679-2817-4d69-9d02-519a537ed0c6 %attrib%
REM REM Processor performance decrease time
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 d8edeb9b-95cf-4f95-a73c-b061973693c8 %attrib%
REM REM Processor performance core parking decrease time
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 dfd10d17-d5eb-45dd-877a-9a34ddd15c82 %attrib%
REM REM Processor performance core parking max cores
REM powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 %attrib%
