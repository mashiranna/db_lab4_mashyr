-- Виводить застосунки заданої категорії

CREATE OR REPLACE PROCEDURE get_app_by_category(category_arg varchar(50))
LANGUAGE 'plpgsql'
AS $$
DECLARE record_name app.app_name%TYPE;
DECLARE record_category app.category%TYPE;

BEGIN
    SELECT app_name, category into record_name, record_category FROM app WHERE category = category_arg;
    RAISE INFO 'app_name: %,  category: %', TRIM(record_name), TRIM(record_category);
END;
$$;

CALL get_app_by_category('Music');