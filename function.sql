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