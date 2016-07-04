sqlplus sys/oracle AS SYSDBA @create_users.sql
sqlplus perf_sys/oracle@ORCL @install_perf_sys.sql
sqlplus perf/oracle@ORCL @install_perf.sql
