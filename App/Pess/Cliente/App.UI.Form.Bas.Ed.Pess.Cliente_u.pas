unit App.UI.Form.Bas.Ed.Pess.Cliente_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Cliente.Ent.Factory_u,
  App.Pess.Cliente.DBI, App.Pess.Cliente.Ent, App.AppInfo, App.Ent.Ed,
  App.Ent.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TPessClienteEdBasForm = class(TPessEdBasForm)
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
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessClienteEdBasForm: TPessClienteEdBasForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.UI.ImgDM;

{ TPessClienteEdBasForm }

procedure TPessClienteEdBasForm.AjusteTabOrder;
begin
  inherited;
//
end;

procedure TPessClienteEdBasForm.ControlesToEnt;
begin
  inherited;
//
end;

constructor TPessClienteEdBasForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  FPessClienteEnt := EntEdCastToPessClienteEnt(pEntEd);
  FPessClienteDBI := EntDBICastToPessClienteDBI(pEntDBI);

  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
end;

function TPessClienteEdBasForm.DadosOk: boolean;
begin
  Result := Inherited;
  if not Result then
    exit;
end;

procedure TPessClienteEdBasForm.EntToControles;
begin
  inherited;
//
end;

end.
