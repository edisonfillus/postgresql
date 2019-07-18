
/* Change all ownership to another user */
REASSIGN OWNED BY old_user TO new_user


/* If owner is postgres, reassing doesn't work, so use this */
DO $$DECLARE r record;
DECLARE
    v_schema varchar := 'schema_to_change';
    v_new_owner varchar := 'new_owner';
BEGIN
    FOR r IN 
        select 'ALTER TABLE "' || table_schema || '"."' || table_name || '" OWNER TO ' || v_new_owner || ';' as a from information_schema.tables where table_schema = v_schema
        union all
        select 'ALTER TABLE "' || sequence_schema || '"."' || sequence_name || '" OWNER TO ' || v_new_owner || ';' as a from information_schema.sequences where sequence_schema = v_schema
        union all
        select 'ALTER TABLE "' || table_schema || '"."' || table_name || '" OWNER TO ' || v_new_owner || ';' as a from information_schema.views where table_schema = v_schema
        union all
        select 'ALTER FUNCTION "'||nsp.nspname||'"."'||p.proname||'"('||pg_get_function_identity_arguments(p.oid)||') OWNER TO ' || v_new_owner || ';' as a from pg_proc p join pg_namespace nsp ON p.pronamespace = nsp.oid where nsp.nspname = v_schema
        union all
        select 'ALTER SCHEMA "' || v_schema || '" OWNER TO ' || v_new_owner 
        union all
        select 'ALTER DATABASE "' || current_database() || '" OWNER TO ' || v_new_owner 
    LOOP
        EXECUTE r.a;
    END LOOP;
END$$;
