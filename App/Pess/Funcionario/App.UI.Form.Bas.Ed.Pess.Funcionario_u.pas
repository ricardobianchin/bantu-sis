unit App.UI.Form.Bas.Ed.Pess.Funcionario_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Funcionario.Ent.Factory_u,
  App.Pess.Funcionario.DBI, App.Pess.Funcionario.Ent, App.AppInfo, App.Ent.Ed,
  App.Ent.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TPessFuncionarioEdBasForm = class(TPessEdBasForm)
  private
    { Private declarations }
    FPessFuncionarioEnt: IPessFuncionarioEnt;
    FPessFuncionarioDBI: IPessFuncionarioDBI;
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
  PessFuncionarioEdBasForm: TPessFuncionarioEdBasForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.UI.ImgDM;

{ TPessFuncionarioEdBasForm }

procedure TPessFuncionarioEdBasForm.AjusteTabOrder;
begin
  inherited;
//
end;

procedure TPessFuncionarioEdBasForm.ControlesToEnt;
begin
  inherited;
//
end;

constructor TPessFuncionarioEdBasForm.Create(AOwner: TComponent;
  pAppInfo: IAppInfo; pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  FPessFuncionarioEnt := EntEdCastToPessFuncionarioEnt(pEntEd);
  FPessFuncionarioDBI := EntDBICastToPessFuncionarioDBI(pEntDBI);

  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
end;

function TPessFuncionarioEdBasForm.DadosOk: boolean;
begin
  Result := Inherited;
  if not Result then
    exit;
end;

procedure TPessFuncionarioEdBasForm.EntToControles;
begin
  inherited;
//
end;

end.
