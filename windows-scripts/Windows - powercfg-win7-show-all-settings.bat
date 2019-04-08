@ECHO OFF
REM SET attrib=+ATTRIB_HIDE
    SET attrib=-ATTRIB_HIDE

REM Harddisk settings
powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 0b2d69d7-a2a1-449c-9680-f91c70521c60 %attrib%
powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 80e3c60e-bb94-4ad8-bbe0-0d3195efc663 %attrib%
powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 dab60367-53fe-4fbc-825e-521d069d2456 %attrib%

REM Sleep transition settings
powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 25DFA149-5DD1-4736-B5AB-E8A37B5B8187 %attrib%
powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 %attrib%
powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 A4B195F5-8225-47D8-8012-9D41369786E2 %attrib%
powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 abfc2519-3608-4c2a-94ea-171b0ed546ab %attrib%
powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 d4c1d4c8-d5cc-43d3-b83e-fc51215cb04d %attrib%

REM Power Scheme Personality
REM NOTE: will not show in UI even if unhidden
powercfg -attributes 245d8541-3943-4422-b025-13a784f679b7 %attrib%

REM Power buttons settings
powercfg -attributes 4f971e89-eebd-4455-a8de-9e59040e7347 833a6b62-dfa4-46d1-82f8-e09e34d029d6 %attrib%

REM Device idle policy
REM NOTE: shows in first node of settings tree if unhidden
powercfg -attributes 4faab71a-92e5-4726-b531-224559672d19 %attrib%

REM Processor power settings
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 06cadf0e-64ed-448a-8927-ce7bf90eb35d %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 1299023c-bc28-4f0a-81ec-d3295a8d815d %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 12a0ab44-fe28-4fa9-b3bd-4b64f44960a6 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 2ddd5a84-5a71-437e-912a-db0b8c788732 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 447235c7-6a8d-4cc0-8e24-9eaf70b96e2b %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 45bcc044-d885-43e2-8605-ee0ec6e96b59 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4b92d758-5a24-4851-a470-815d78aee119 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 5b33697b-e89d-4d38-aa46-9e7dfb7cd2f9 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 68dd2f27-a4ce-4e11-8487-3794e4135dfa %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 6c2993b0-8f48-481f-bcc6-00dd2742aa06 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 71021b41-c749-4d21-be74-a00f335d582b %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 7b224883-b3cc-4d79-819f-8374152cbe7c %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 7d24baa7-0b84-480f-840c-1b0743c00f5f %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 8809c2d8-b155-42d4-bcda-0d345651b1db %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 8f7b45e3-c393-480a-878c-f67ac3d07082 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 984cf492-3bed-4488-a8f9-4286c97bf5aa %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 9ac18e92-aa3c-4e27-b307-01ae37307129 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 a55612aa-f624-42c6-a443-7397d064c04f %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 c4581c31-89ab-4597-8e2b-9c9cab440e6b %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 c7be0679-2817-4d69-9d02-519a537ed0c6 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 d8edeb9b-95cf-4f95-a73c-b061973693c8 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 df142941-20f3-4edf-9a4a-9c83d3d717d1 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 dfd10d17-d5eb-45dd-877a-9a34ddd15c82 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 e70867f1-fa2f-4f4e-aea1-4d8a0ba23b20 %attrib%
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 %attrib%

REM Video settings
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 82DBCF2D-CD67-40C5-BFDC-9F1A5CCD4663 %attrib%
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 90959d22-d6a1-49b9-af93-bce885ad335b %attrib%
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 A9CEB8DA-CD46-44FB-A98B-02AF69DE4623 %attrib%
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcd %attrib%
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bce %attrib%
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 EED904DF-B142-4183-B10B-5A1197A37864 %attrib%
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 FBD9AA66-9553-4097-BA44-ED6E9D65EAB8 %attrib%

REM Citation: Pulled from [ https://gist.github.com/theultramage/cbdfdbb733d4a5b7d2669a6255b4b94b ] on [ 20190104-135522-0500 ]