/* Disable all connections (including postgres) */
update pg_database set datallowconn = true where datname = 'db';

/* Disable all connections (including postgres) PostgreSQL 9.5+ */
ALTER DATABASE 'db' WITH ALLOW_CONNECTIONS false;

/* Disable all connections (excluding postgres) */
ALTER DATABASE dbname CONNECTION LIMIT 0;


/* Kill all connections PostgreSQL 9.2+*/
select pg_terminate_backend(pid) 
from pg_stat_activity 
where pid <> pg_backend_pid() and datname = 'dbname';

/* Kill all connections PostgreSQL até 9.2*/
select pg_terminate_backend(procpid)
from pg_stat_activity
where procpid <> pg_backend_pid() and datname = 'dbname';


/* Change database name */
ALTER DATABASE dbname RENAME TO dbname2;

/* Re-enable all connections */
ALTER DATABASE dbname CONNECTION LIMIT -1;