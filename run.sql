-- Функція:
-- видаляє не безкоштовні застосунки

CREATE OR REPLACE FUNCTION del_not_free() RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN 
   DELETE FROM app 
   WHERE app.price IN 
      (SELECT app.price from app where app.price <> 0);
END;
$$;

SELECT del_not_free();

-- Процедура:
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


-- Тригер:
-- перевіряє чи не порожні дані вводяться в назву застосунку
CREATE TRIGGER unique_app_name
AFTER INSERT OR UPDATE ON app
FOR EACH ROW EXECUTE PROCEDURE check_unique();

CREATE OR REPLACE FUNCTION check_unique() RETURNS trigger AS
$$
	BEGIN
		IF NEW.app_name IS NULL THEN 
 			RAISE INFO  'APP NAME CAN NOT BE EMPTY';
		END IF;
		RETURN NULL;
	END;
$$ 
LANGUAGE 'plpgsql';

INSERT INTO app(publisher, price) 
VALUES('Abdului', 10)
