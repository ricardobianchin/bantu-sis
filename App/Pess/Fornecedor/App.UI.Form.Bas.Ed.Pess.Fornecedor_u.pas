unit App.UI.Form.Bas.Ed.Pess.Fornecedor_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Fornecedor.Ent.Factory_u,
  App.Pess.Fornecedor.DBI, App.Pess.Fornecedor.Ent, App.AppObj, App.Ent.Ed,
  App.Ent.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Mask;

type
  TPessFornecedorEdForm = class(TPessEdBasForm)
    Label1: TLabel;
    Label2: TLabel;
    AjudaApelidoLabel: TLabel;
    ApelidoObrigLabel: TLabel;
    procedure ApelidoPessEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPessFornecedorEnt: IPessFornecedorEnt;
    FPessFornecedorDBI: IPessFornecedorDBI;
  protected
    function ApelidoOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessFornecedorEdForm: TPessFornecedorEdForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.UI.ImgDM, Sis.UI.Controls.TLabeledEdit, Sis.Types;

{ TPessFornecedorEdForm }

function TPessFornecedorEdForm.ApelidoOk: boolean;
var
  s: string;
  bEncontrado: boolean;
  iExcetoLojaId: smallint;
  iExcetoPessoaId: integer;

  iEncontradoLojaId: smallint;
  iEncontradoPessoaId: integer;
  sEncontradoCod: string;
  sEncontradoNome: string;
begin
  // Result := inherited;
  // if not Result then
  // exit;

  Result := (ActiveControl = CancelBitBtn_DiagBtn) or
    (ActiveControl = MensCopyBitBtn_DiagBtn);
  if Result then
    exit;

  s := Trim(ApelidoPessEdit.Text);
  Result := s <> '';
  if not Result then
  begin
    ErroOutput.Exibir('O Apelido é obrigatório');
    ApelidoPessEdit.SetFocus;
    exit;
  end;

  FPessFornecedorDBI.ApelidoTem(s, bEncontrado, iEncontradoLojaId,
    iEncontradoPessoaId, sEncontradoNome, FPessFornecedorEnt.LojaId,
    FPessFornecedorEnt.Id);

  Result := not bEncontrado;

  if not Result then
  begin
    sEncontradoCod := CodsToCodAsString(iEncontradoLojaId, 0,
      iEncontradoPessoaId, FPessFornecedorEnt.CodUsaTerminalId);

    ErroOutput.Exibir('O fornecedor ' + sEncontradoCod +' - '+ sEncontradoNome +
      ' já possui o apelido ' + QuotedStr(sEncontradoNome));
    exit;
  end;
end;

procedure TPessFornecedorEdForm.ApelidoPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    NomePessEdit.SetFocus;
  end;
  inherited;
end;

constructor TPessFornecedorEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  FPessFornecedorEnt := EntEdCastToPessFornecedorEnt(pEntEd);
  FPessFornecedorDBI := EntDBICastToPessFornecedorDBI(pEntDBI);

  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);

  AjudaApelidoLabel.Hint := 'Um apelido único, fácil de lembrar,'#13#10 +
    'que será usado no sistema para'#13#10 + 'identificar o fornecedor';
end;

end.
