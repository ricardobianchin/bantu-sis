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
  private
    { Private declarations }
    FPessFornecedorEnt: IPessFornecedorEnt;
    FPessFornecedorDBI: IPessFornecedorDBI;
  protected
    procedure AjusteTabOrder; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function DadosOk: boolean; override;
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
  Sis.Types.Integers, Sis.UI.ImgDM;

{ TPessFornecedorEdForm }

procedure TPessFornecedorEdForm.AjusteTabOrder;
begin
  inherited;
  //
end;

procedure TPessFornecedorEdForm.ControlesToEnt;
begin
  inherited;
  //
end;

constructor TPessFornecedorEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  FPessFornecedorEnt := EntEdCastToPessFornecedorEnt(pEntEd);
  FPessFornecedorDBI := EntDBICastToPessFornecedorDBI(pEntDBI);

  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
end;

function TPessFornecedorEdForm.DadosOk: boolean;
begin
  Result := Inherited;
  if not Result then
    exit;
end;

procedure TPessFornecedorEdForm.EntToControles;
begin
  inherited;
  //
end;

end.
