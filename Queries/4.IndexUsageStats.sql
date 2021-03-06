SELECT
	OBJECT_NAME(I.OBJECT_ID) AS TableName, 
	I.Name AS IndexName, 
	COALESCE(USER_SEEKS, 0) AS Seeks, 
	COALESCE(USER_SCANS, 0) AS Scans, 
	COALESCE(USER_LOOKUPS, 0) AS Lookups, 
	COALESCE(USER_UPDATES, 0) AS Updates 
FROM     
	SYS.INDEXES AS I 
	LEFT JOIN SYS.DM_DB_INDEX_USAGE_STATS AS S  
    ON I.OBJECT_ID = S.OBJECT_ID 
    AND I.INDEX_ID = S.INDEX_ID
WHERE
	OBJECTPROPERTY(I.OBJECT_ID,'IsUserTable') = 1 
ORDER BY 
	COALESCE(USER_SEEKS, 0) + COALESCE(USER_SCANS, 0) + COALESCE(USER_LOOKUPS, 0) DESC;