SET TERM ^;

CREATE OR ALTER PACKAGE GER_FORM_PA
AS
BEGIN
  PROCEDURE CONFIGS_GET
  RETURNS
  (
    SEMPRE_VISIVEL BOOLEAN,
    AUTO_OPEN BOOLEAN
  );
  
  PROCEDURE SEMPRE_VISIVEL_SET
  (
    VALOR BOOLEAN
  );

  PROCEDURE AUTO_OPEN_SET
  (
    VALOR BOOLEAN
  );

END^

RECREATE PACKAGE BODY GER_FORM_PA
AS
BEGIN
  PROCEDURE CONFIGS_GET
  RETURNS
  (
    SEMPRE_VISIVEL BOOLEAN,
    AUTO_OPEN BOOLEAN
  )
  AS
    DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    STMP = CONFIG_SIS_PA.VALOR_GET('GER_FORM/SEMPRE_VISIVEL');
    SEMPRE_VISIVEL = COALESCE(UPPER(STMP) = 'S', FALSE);

    STMP = CONFIG_SIS_PA.VALOR_GET('GER_FORM/AUTO_OPEN');
    AUTO_OPEN = COALESCE(UPPER(STMP) = 'S', FALSE);

    SUSPEND;
  END

  PROCEDURE SEMPRE_VISIVEL_SET
  (
    VALOR BOOLEAN
  )
  AS
    DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    STMP = IIF(VALOR, 'S', NULL);
    
    EXECUTE PROCEDURE CONFIG_SIS_PA.GARANTIR('GER_FORM/SEMPRE_VISIVEL', STMP);
  END
  
  PROCEDURE AUTO_OPEN_SET
  (
    VALOR BOOLEAN
  )
  AS
    DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    STMP = IIF(VALOR, 'S', NULL);
    
    EXECUTE PROCEDURE CONFIG_SIS_PA.GARANTIR('GER_FORM/AUTO_OPEN', STMP);
  END
  
END^
SET TERM ;^
