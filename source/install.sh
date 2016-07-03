sqlplus sys/oracle as sysdba @create_users.sql
sqlplus perf_sys/oracle@orcl @install_perf_sys.sql
sqlplus perf/oracle@orcl @install_perf.sql
