unit App.UI.Acesso.OpcaoSis.TreeView.Preenchedor.SQL_u;

interface

// param
// 0 = opcao superior
// 1 = perfil

function GetSQLOpcoesPerfil: string;

implementation

function GetSQLOpcoesPerfil: string;
begin
  Result :=

        'WITH O AS ('#13#10 //
      + '  SELECT'#13#10 //
      + '    OPCAO_SIS_ID,'#13#10 //
      + '    NOME,'#13#10 //
      + '    OPCAO_TIPO_SIS_ID'#13#10 //
      + '  FROM OPCAO_SIS'#13#10 //
                                     // param 0
      + '  WHERE OPCAO_SIS_ID_SUPERIOR = :OPCAO_SIS_ID_SUPERIOR'#13#10 //

      + '), P AS ('#13#10 //
      + '  SELECT'#13#10 //
      + '    PERFIL_DE_USO_ID,'#13#10 //
      + '    OPCAO_SIS_ID'#13#10 //
      + '  FROM PERFIL_DE_USO_PODE_OPCAO_SIS'#13#10 //
                                     // param 1
      + '  WHERE PERFIL_DE_USO_ID = :PERFIL_DE_USO_ID'#13#10 //

      + ')'#13#10 //

      + 'SELECT'#13#10 //
      + '  O.OPCAO_SIS_ID,'#13#10 //
      + '  O.NOME,'#13#10 //
      + '  O.OPCAO_TIPO_SIS_ID,'#13#10 //
      + '  (NOT P.PERFIL_DE_USO_ID IS NULL) TEM'#13#10 //
      + 'FROM O'#13#10 //
      + 'LEFT JOIN P ON'#13#10 //
      + '  O.OPCAO_SIS_ID = P.OPCAO_SIS_ID'#13#10 //
      + 'ORDER BY O.OPCAO_TIPO_SIS_ID DESC, O.NOME ASC'#13#10 //
      + ';'#13#10 //
      ;

end;

end.
