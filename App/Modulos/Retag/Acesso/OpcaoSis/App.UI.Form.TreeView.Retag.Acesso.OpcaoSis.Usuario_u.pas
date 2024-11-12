unit App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.Usuario_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis_u, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Sis.Config.SisConfig,
  Sis.DB.DBTypes, App.AppObj;

type
  TOpcaoSisUsuarioTreeViewForm = class(TOpcaoSisTreeViewForm)
  private
    { Private declarations }
    FLojaId: smallint;
    FUsuarioIdLog: integer;
  protected
    function GetSql: string; override;
    function GetSqlGravar: string; override;

    function GetEntidadeAssociada: string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pLojaId: smallint;
      pUsuarioIdLog: integer; pUsuarioIdEnvolvido: integer;
      pUsuarioNomeEnvolvido: string; pAppObj: IAppObj; pDBMS: IDBMS); reintroduce;
  end;

var
  OpcaoSisUsuarioTreeViewForm: TOpcaoSisUsuarioTreeViewForm;

implementation

{$R *.dfm}
{ TOpcaoSisUsuarioTreeViewForm }

constructor TOpcaoSisUsuarioTreeViewForm.Create(AOwner: TComponent; pLojaId: smallint;
      pUsuarioIdLog: integer; pUsuarioIdEnvolvido: integer;
      pUsuarioNomeEnvolvido: string; pAppObj: IAppObj; pDBMS: IDBMS);
begin
  FLojaId := pLojaId;
  FUsuarioIdLog := pUsuarioIdLog;
  inherited Create(AOwner, pUsuarioIdEnvolvido, pUsuarioNomeEnvolvido, pAppObj, pDBMS);
end;

function TOpcaoSisUsuarioTreeViewForm.GetEntidadeAssociada: string;
begin
  Result := 'Usuário';
end;

function TOpcaoSisUsuarioTreeViewForm.GetSql: string;
begin
  Result := //
    'WITH O AS ('#13#10 + //
    '  SELECT'#13#10 + //
    '    OPCAO_SIS_ID,'#13#10 + //
    '    NOME,'#13#10 + //
    '    OPCAO_TIPO_SIS_ID'#13#10 + //
    '  FROM OPCAO_SIS'#13#10 + //
  // param 0
    '  WHERE OPCAO_SIS_ID_SUPERIOR = :OPCAO_SIS_ID_SUPERIOR'#13#10 + //

    '), P AS ('#13#10 + //
    '  SELECT'#13#10 + //
    '    PESSOA_ID,'#13#10 + //
    '    OPCAO_SIS_ID'#13#10 + //
    '  FROM USUARIO_PODE_OPCAO_SIS'#13#10 + //

    '  WHERE LOJA_ID = ' + FLojaId.ToString + #13#10 + //
    '  AND TERMINAL_ID = 0'#13#10 + //
  // param 1
    '  AND PESSOA_ID = :PESSOA_ID'#13#10 + //
    ')'#13#10 + //

    'SELECT'#13#10 + //
    '  O.OPCAO_SIS_ID,'#13#10 + //
    '  O.NOME,'#13#10 + //
    '  O.OPCAO_TIPO_SIS_ID,'#13#10 + //
    '  (NOT P.PESSOA_ID IS NULL) TEM'#13#10 + //
    'FROM O'#13#10 + //
    'LEFT JOIN P ON'#13#10 + //
    '  O.OPCAO_SIS_ID = P.OPCAO_SIS_ID'#13#10 + //
    'ORDER BY O.OPCAO_TIPO_SIS_ID DESC, O.NOME ASC'#13#10 + //
    ';'#13#10 //
    ;
end;

function TOpcaoSisUsuarioTreeViewForm.GetSqlGravar: string;
var
  sLista: string;
begin
  sLista := NodesListAsString;

  Result := 'EXECUTE PROCEDURE USUARIO_PA.PODE_OPCOES_GARANTIR(' //
    + AppObj.Loja.Id.ToString // LOJA_ID
    + ', ' + AssociadaId.ToString // USUARIO_PESSOA_ID
    + ', ' + FUsuarioIdLog.ToString // LOG_PESSOA_ID
    + ', ' + AppObj.SisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ', ' + QuotedStr(sLista) // STR_OPCOES_ID
    + ');' //
    ;
end;

end.
