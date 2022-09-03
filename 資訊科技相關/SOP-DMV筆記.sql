-- SOP-DMV筆記

/*
  利用DMV觀察查詢執行時的各個環節資訊,從中找到可修正或調整的地方,以提升查詢效率
  - 查詢的執行計劃(cached plan)
  - 使用哪些索引(what indexes were used)
  - 哪些索引查詢想用卻無法使用,因為索引遺失(what indexes the query would like to use but can't, because they're missing.)
  - 發生多少 I/O(實體或邏輯)
  - 查詢執行時間
  - 等待其他資源的時間
  - 有哪些資源是查詢所等待的

  1.所有 DMV & DMF 都隸屬於 <sys> schema
  2.所有 DMV 長像 sys.dm_<subsystem name>

*/

-- 目前執行的requests有哪些
SELECT * FROM sys.dm_exec_requests;

/*
  如何使用DMV呢?
  1.1.2. 彙總結果,並作前後期差異比較
  1.1.3. 考慮DMV執行,是否會影響SQLServer效能
          (大部份不會,但是某些DMV確實會影響。
          例:計算索引分割程度的 sys.dm_db_index_physical_stats，就會影響)
  1.1.4. SQL Server內有哪些可用DMV項目?
*/

-- 查詢可用的DMV項目
SELECT name , type_desc
FROM sys.system_objects
WHERE name LIKE 'dm_%'
ORDER BY name;

/*
  1.2 DMV可以解決哪些問題呢？
    1.2.1. Diagnosing problems(診斷問題所在)
      問題範例:解決USER反應查詢太慢的效能問題
      a.利用DMV檢查查詢執行計劃
        , 如何存取資料
        , 使用哪些資源(例:是否使用了索引 或 Table scan) 
        , 統計資訊是否過期
        , 辨別任何遺失索引
      b.找出問題點後, 再提出對策
      c.也有可能是查詢太複雜且包含大量的函式所造成 , 這時可拆解為較小步驟也是解法之一
    1.2.2. Performance tuning(效能調整,ex.通常愈少IO,反應較快的查詢)
      a.使用建議作法對診斷出來的問題，進行調整 == Performance tuning.
        ex.applying a missing index
        ex.remove contention(爭奪)/blocking(阻擋)
        ex.determining the degree of fragmentation.
      b.任何改善的衡量會反應在 <執行時間> or <I/O counts>
      c.Performance tuning 是個反覆過程(改善後, 再決定是否必須作到極緻, 或將焦點放在其他更重要的問題上)
    1.2.3. Monitoring(監控 , sys.dm_exec_..)
      a.有時候,問題發生在夜間批次處理, 回報 timeoue or slow_running queries.
        => 這時, 找出當下執行的SQL command(利用 overnight batch scheduler or sp_who2)
        => 如果要清楚地知道 "Specific lines of SQL are executing ?" , "SQL查詢如何互動?" , "是否發生blocking?"
          => 這些問題 , 可以利用DMV得到解答
          => dba_BlockTracer.sql
            https://github.com/PNNL-Comp-Mass-Spec/DBSchema_DMS/blob/master/MasterDB/dba_BlockTracer.sql
          => dba_WhatSQLIsExecuting.sql
            https://www.sqlservercentral.com/articles/what-sql-statements-are-currently-executing
*/

/*A simple monitor 
  當BLOCK發生時,可以監控目前執行中的SQL
*/
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  WAITFOR TIME '19:00:00'
  GO
  PRINT GETDATE()
  EXEC master.dbo.dba_Blocktracer

  IF @@ROWCOUNT > 0
  BEGIN
    SELECT GETDATE() AS TIME
    EXEC master.dbo.dba_WhatSQLIsExecuting
  END

  WAITFOR DELAY '00:00:15'
  --GO 500 --上一個GO之後指令會重覆500次

/*
  1.3 DMV example
    加上下列指令,可減少其他查詢影響,加快查詢回應速度
*/
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/*
  1.3.1 Find your slowest queries (找出最慢查詢)
*/
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  SELECT TOP 20
    CAST(qs.total_elapsed_time / 1000000.0 as DECIMAL(28,2))
                                        as [total elapsed duration(s)]
    , qs.execution_count
    , SUBSTRING(
        qt.text , (qs.statment_start_offset/2) + 1 ,
        (( CASE WHEN qs.statement_end_offset = -1
           THEN 
            LEN(CONVERT(nvarchar(max),qt.text)) * 2
           ELSE 
            qs.statement_start_offset
           END - qs.statement_start_offset)/2) + 1 ) as [individual query]
    , qt.text as [parent query]
    , DB_NAME(qt.dbid) as DatabaseName
    , qp.query_plan
  FROM sys.dm_exec_query_stats qs
  CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
  CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
  ORDER BY total_elapsed_time DESC

/*
  1.3.2 Find those missing indexes (找出遺失的索引)
*/

/*
  1.3.3 Identify what SQL statements are running now (辨別正在執行的SQL)
*/

/*
  1.3.4 Quickly find a cached plan
*/

/*
  1.4 Preparing to use DMV (使用DMV前的前置作業)
*/

/*
  1.4.1 Permissions (開啟相關權限)
    VIEW SERVER STATE --SERVER SCOPED
    VIEW DATABASE STATE  --DATABASE SCOPED
    另外,上述權限建議指派給特定login , EX. DMV_Viewer , 而非整個群組或使用者
    ALTER SERVER STATE --如果要有清除DMV功能 , 還要另外給這項權限
  1.4.2 Clearing DMVs (清除DMV)
    DBCC FREEPROCCACHE --清掉SQLServer內所有DB的cached plans
    DBCC FREEPROCCACHE sql_handle | plan_handle | pool_name --清除特定範圍的cached plans
*/
  
  DECLARE @DB_ID INT --清掉特定DB的cached plans
  SET @DB_ID = DB_ID('NameOfDatabaseToClear') --改為你要清cached plans的DB名稱
  DBCC FLUSHPROCINDB(@DB_ID)

/*
  1.5 DMV的好夥伴
    1.5.1. <Catalog Views> , 它是靜態資料 , 與DMV動態資料結合 , 可獲得更有意義的OUTPUT. 
           ex. sys.objects , sys.tables
    1.5.2. <Cached plans> , 執行計劃 . 當查詢執行時 , 一定會先產生執行計劃後 , 再依此執行
           它清楚地顯示查詢的執行方式(索引使用,統計資訊)
    1.5.3. <Indexes> , 索引 . 
           nonclustered indexes == 非叢集索引 , 適用於精準抓出小部份資料時
           clustered indexes == 叢集索引 , 適用於大區間資料範圍時 , 例:報告製作
            資料依此索引作排序與儲存 , 每個資料表只能一個叢集索引 . 如果資料表沒有叢集索引, 則資料會塞在最後面, 又稱為堆積
    1.5.4. <Statistics>, 統計資料 of 資料表
           a.統計資料 => 是協助決定最佳查詢方式的依據,如果它是過時/陳舊stale的,那cached plan可能非最佳查詢方法
           b.定期更新統計資料 is very important.(非常重要) ex. using a scheduled job to update the statistics
             通常成熟系統上的大資料表 , 統計資料是否及時(up-to-date)會是影響效能的一大關鍵
*/

/*
  1.6 Working with DMVs
    
*/

/*
備份：完整、差異、大量紀錄
差異備份的前提是，必須要有完整備份。
*/

