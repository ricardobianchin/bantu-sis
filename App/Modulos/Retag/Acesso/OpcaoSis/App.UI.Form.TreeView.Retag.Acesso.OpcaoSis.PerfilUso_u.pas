unit App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.PerfilUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis_u, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TOpcaoSisPerfilUsoTreeViewForm = class(TOpcaoSisTreeViewForm)
  private
    { Private declarations }
  protected
    function GetSql: string; override;
    function GetSqlGravar: string; override;

    function GetEntidadeAssociada: string; override;
  public
    { Public declarations }
  end;

var
  OpcaoSisPerfilUsoTreeViewForm: TOpcaoSisPerfilUsoTreeViewForm;

implementation

{$R *.dfm}

uses Sis.Win.Utils_u;

{ TOpcaoSisPerfilUsoTreeViewForm }

function TOpcaoSisPerfilUsoTreeViewForm.GetEntidadeAssociada: string;
begin
  Result := 'Perfil de Uso';
end;

function TOpcaoSisPerfilUsoTreeViewForm.GetSql: string;
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

function TOpcaoSisPerfilUsoTreeViewForm.GetSqlGravar: string;
var
  sLista: string;
begin
  sLista := NodesListAsString;

  Result := 'EXECUTE PROCEDURE PERFIL_DE_USO_PA.PODE_OPCOES_GARANTIR(' +
    AssociadaId.ToString + ', ' + QuotedStr(sLista) + ');';
end;

end.
