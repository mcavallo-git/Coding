-- ------------------------------------------------------------
-- MySQL - Get global variables (@@variables)
-- ------------------------------------------------------------

SELECT
@@innodb_buffer_pool_size,
@@innodb_buffer_pool_instances,
-- @@innodb_autoextend_increment,
-- @@innodb_concurrency_tickets,
-- @@innodb_io_capacity,
-- @@innodb_io_capacity_max,
-- @@innodb_old_blocks_time,
-- @@innodb_open_files,
-- @@innodb_purge_batch_size,
@@innodb_purge_threads,
@@innodb_stats_on_metadata,
@@max_allowed_packet

