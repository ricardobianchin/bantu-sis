unit App.UI.Form.Bas.Ed.Pess.Cliente_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Cliente.Ent.Factory_u,
  App.Pess.Cliente.DBI, App.Pess.Cliente.Ent, App.AppObj, App.Ent.Ed,
  App.Ent.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TPessClienteEdForm = class(TPessEdBasForm)
  private
    { Private declarations }
    FPessClienteEnt: IPessClienteEnt;
    FPessClienteDBI: IPessClienteDBI;
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
  PessClienteEdForm: TPessClienteEdForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.UI.ImgDM;

{ TPessClienteEdBasForm }

procedure TPessClienteEdForm.AjusteTabOrder;
begin
  inherited;
//
end;

procedure TPessClienteEdForm.ControlesToEnt;
begin
  inherited;
//
end;

constructor TPessClienteEdForm.Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI);
begin
  FPessClienteEnt := EntEdCastToPessClienteEnt(pEntEd);
  FPessClienteDBI := EntDBICastToPessClienteDBI(pEntDBI);

  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
end;

function TPessClienteEdForm.DadosOk: boolean;
begin
  Result := Inherited;
  if not Result then
    exit;
end;

procedure TPessClienteEdForm.EntToControles;
begin
  inherited;
//
end;

end.
