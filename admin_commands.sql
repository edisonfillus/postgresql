/* Kill all processes on database */

SELECT
    pg_terminate_backend (pid)
FROM
    pg_stat_activity
WHERE
    datname = 'dbname';

/* Change database name */
ALTER DATABASE assdb001_testes RENAME TO aasdb001_testes;


/* Change all ownership to another user */
REASSIGN OWNED BY old_user TO new_user


/* Grant all */
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA foo TO mygrp;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA foo TO mygrp;

/* Default Grant */
ALTER DEFAULT PRIVILEGES IN SCHEMA foo GRANT ALL PRIVILEGES ON TABLES TO mygrp;
ALTER DEFAULT PRIVILEGES IN SCHEMA foo GRANT USAGE          ON SEQUENCES TO mygrp;