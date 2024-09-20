unit App.UI.Form.Diag.Pess.Funcionario.PerfilDeUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn.CheckListView_u, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons,
  App.Pess.Funcionario.DBI, App.Pess.Funcionario.Ent;

type
  TFuncionarioPerfilDeUsoDiagForm = class(TCheckListViewDiagBasForm)
  private
    { Private declarations }
    FFuncionarioEnt: IPessFuncionarioEnt;
    FFuncionarioDBI: IPessFuncionarioDBI;
  protected
    procedure PreencherCheckListBox; override;
    function PodeOk: Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFuncionarioEnt: IPessFuncionarioEnt;
      pFuncionarioDBI: IPessFuncionarioDBI); reintroduce;
  end;

var
  FuncionarioPerfilDeUsoDiagForm: TFuncionarioPerfilDeUsoDiagForm;

implementation

{$R *.dfm}
{ TFuncionarioPerfisDeUsoDiagForm }

constructor TFuncionarioPerfilDeUsoDiagForm.Create(AOwner: TComponent;
  pFuncionarioEnt: IPessFuncionarioEnt; pFuncionarioDBI: IPessFuncionarioDBI);
var
  sCaption: string;
  sTitulo: string;
begin

  FFuncionarioEnt := pFuncionarioEnt;
  FFuncionarioDBI := pFuncionarioDBI;

  sCaption := 'Perfis de Uso do Funcionário';
  sTitulo := 'Perfis de Uso de: ' + FFuncionarioEnt.Apelido;

  inherited Create(AOwner, sCaption, sTitulo);
end;

function TFuncionarioPerfilDeUsoDiagForm.PodeOk: Boolean;
var
  iLojaId: smallint;
  iPessoaId: integer;
  sStrPerfisId: string;
begin
  Result := inherited;
  if not Result then
    exit;

  iLojaId := FFuncionarioEnt.LojaId;
  iPessoaId := FFuncionarioEnt.Id;
  sStrPerfisId := IdsSelecionadasAsStringCSV;

  Result := FFuncionarioDBI.GravarPerfis(iLojaId, iPessoaId, sStrPerfisId,
    ErroOutput);
end;

procedure TFuncionarioPerfilDeUsoDiagForm.PreencherCheckListBox;
begin
  inherited;
  FFuncionarioDBI.PreencherCheckListBox(CheckListBox1, ErroOutput);
end;

end.
