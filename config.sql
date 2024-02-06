DELETE FROM lum_CfgEnvironmentConf;

INSERT INTO lum_CfgEnvironmentConf (id, type, fileSystemImplementation, javaMelodyEnabled, bigDataRepositoryType ,esHttpConnectionAddresses, esBulkConcurrentRequests, useUserGroupsSessionCache, prSystemEnabled, prActivityAnonymize) 
VALUES(  '000000000A00000000000A0000100000', 'DEVELOPMENT','lumis.portal.filesystem.impl.ClusterMirroredFileSystem', 1,'ELASTICSEARCH_TRANSPORT_CLIENT',  'ELASTICSEARCH_HOST:9200', 10,1, 1, 'ANONYMIZE_FIELDS');

UPDATE lum_Website set webRootPath='WEB_ROOT_PATH' where name ='default';
UPDATE lum_WebsiteBaseURL set path =null;
UPDATE lum_WebsiteBaseURL set port=80 where port = 8080;